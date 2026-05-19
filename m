Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2635CB7B;
	Tue, 19 May 2026 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223145; cv=none; b=l1XhPHp0WwRV/r0EZ5P/n1fzjY/O8aenT6VXqOSuCeSNx1+giHMRhcFzaM3wP1zU4ahup/QazJ4y9LckFGZzvXjDL/FtBlYNwIzr5xqnWguQlrJMP6YGtmI5S3fD8mqx6bwgJGkmCMYlDno/Kp9Ikf1sBVoPrv/fP7FP7GgVV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223145; c=relaxed/simple;
	bh=PQf6/piVWjV+FE6Tk0HuRxKAa75nocAJDRXBLpFxFTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRmsTKGHNhULs4kF8Xm6P9S03UyUAcie7WQVnixbEQyVUg9TCHpAV2WSA9hXl8gL9RtmJTSLOyKiInLg5suyZpCGk7+Og269PUtciK2zpBhcJy5J1jBew6tpgWNQjlo910k8MgRl5lnUo6HOp8ROdPzWGHwIaSR43dCNvFEcxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSq+fUy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSq+fUy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4B41F000E9;
	Tue, 19 May 2026 20:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779223144;
	bh=nl1gbs2fK7pMLwKSqCSWCOj1PGFB0xK6UxCu60PXmvg=;
	h=From:To:Cc:Subject:Date;
	b=lSq+fUy55KhBxEqE67LZB9w7eyp+SH62ljqR8dTAlf9dkJYZIW5ypJDKvJVPfnCqd
	 bG3D2wNZete082KGtdU7gwhb/ncE2ZM9AoUKgPy7e9Ml0Keb6DeXXu7SC9LeYQ2F24
	 MudYzbhGVt+wJNGtan9dGFk3v7soxj4n1yngYB2/ZnE49lnX+HsGf4qwTaStrXgenl
	 GleK388UFxyjOo9E9491eWb94Avx9vaBH8py78ruAbfAJGIJGMTuvgFRcECnDzpwiT
	 OmcWpgVaE0mpafFGbabv+AIgZYQAKGJ9goawoZ8esHI3S7T79lZKZ6R0OmAwwCzK8J
	 fCT0Rglk0N0TA==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: avoid padding in struct bpf_common_attr
Date: Tue, 19 May 2026 22:38:38 +0200
Message-Id: <20260519203858.1342507-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building linux/bpf.h with -Wpadded shows an unintentionally
added portion of padding because of the 64-bit alignment:

./usr/include/linux/bpf.h:1510:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]

Avoid this by adding explicit padding.

Fixes: f28771c0691b ("bpf: Extend BPF syscall with common attributes support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cc4c0b62cdfa..0f0ec00cae4a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1507,6 +1507,7 @@ struct bpf_common_attr {
 	__u32 log_size;
 	__u32 log_level;
 	__u32 log_true_size;
+	__u32 __pad;
 };
 
 #define BPF_OBJ_NAME_LEN 16U
-- 
2.39.5

