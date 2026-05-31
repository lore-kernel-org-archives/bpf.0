Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F0273D8D
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780188508; cv=none; b=e5Bw6YZzCWNXW7BEm+7jzsNB34JBnLntxkRV1KjYDHYrY5MN25cCCTIFXG7KxKxf+Q9awQOc05BRIgRrPeLrOEN+IjkKhZ0htXl1WatQjyb7ruE66nd5OCHottfXtqe0a1aYgU910MruVendhtGEtd5leTbvJNn8XPlzpoPJh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780188508; c=relaxed/simple;
	bh=rZKT3WfpcAM0Di6SKFP/V+72/2OaBqpDTNVwYt9MKvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g6NMpTZHo55sOLgJb6w1s2mfgVO7YFYWRek3fYE0Ex0Hwm9T6o2c3LjA43TCDaXP+cFmOqRlrNKOlnOfCZtHuUIaB4leEfCD1+P7XBS/9qId2Xhn+1hxn3bkpF+nROWjd3hKcK4H3DhxEYQHt4q/DqYAxCZVLcuUdUX9t9RYKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0QAk2mx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0QAk2mx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so1776507a91.3
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 17:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780188507; x=1780793307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVPwV2ysloi40QFLeoMaNeuGhaFgrYtYqToJPyLkcEI=;
        b=r0QAk2mx9/Sxq+H6IGtRcEuNP+OVGwdB7/KXJboVtSOSpzxvlRnBB54zxc4CoHwEkA
         PmrRelVBPO45yBiWgZmcf08u15xDkVwtyZ5yxWzsmG7BkwwzGIbf0pb7mefGhRdQIJcN
         5ityawrBnzkeHVBE67InH9d3oEswj0UEniDYlgLt7Vnoafdt9f96sDh6k69G+PUPxx4A
         Be70SxLs7V7Jx3Pzf6klX4CE9m98XLtl/2VcLBXMULo+kBg9xcSy72dhbhUDLrehuM0a
         PeAguxBkDlxqlIk2N8vms1N33WzpSiDFO8eLUPs/hZSr2qCdfcC8bZjbEqGa5un5q6jD
         4SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780188507; x=1780793307;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SVPwV2ysloi40QFLeoMaNeuGhaFgrYtYqToJPyLkcEI=;
        b=aqAagkss4Re6Kn+4YZMrLOuwCFVCkNwPq06u5q0r8tKKC9hvAyjFRa0rzxx57WtFwc
         XXEeULQQvz4YdjHNs3vBM4Udy4KgvCtNtTMTWfVEzGPBaRIvAjPlw0pe4kacqz7R8Dd8
         MZMMQlRIWFdsxztauzjG8RQAPqWSuvvcfh+lR5mECKd7Y/lzrKU/mL46GDwN5VSKdHI8
         HDyq6nGxZjrjapK4YVk7gsd/ppj/+lzVGx1rTsQ1yNczH5Eg8OWWFUES7zkLaMouMNYQ
         wG8u77yjPcJg4i9cb4aT6KcjAA4NbScsiVZ/yei6VaEOUne+nkFtMz5uX8jZVgW18BdU
         L7aQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pyOadO2BzIv8iBitFLvvV6V2XX2MeHB4/7lWgbibB5Ul/pNU84vpeW3fF1zBe9FAPF3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcSrbYmCJOrDXQBvFUiUFpLbrgUI2iGLbYvFiE0XraSU+iA37
	i8ccS7akzb2upRBNjJBElxp/DjLdvo+FSk5kYcpdfMNpSMnaTaWeKXfonqsdsdfV5q0uCzL1kks
	cL7Qr7rWjFi5rfXddjpCAnHwUbQ==
X-Received: from pgvc19.prod.google.com ([2002:a65:6193:0:b0:c85:9c9a:ab5c])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e8a:b0:36d:64c1:8b5f with SMTP id 98e67ed59e1d1-36d64c18c3bmr3679839a91.27.1780188506522;
 Sat, 30 May 2026 17:48:26 -0700 (PDT)
Date: Sun, 31 May 2026 08:47:47 +0800
In-Reply-To: <20260531004748.3567875-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531004748.3567875-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531004748.3567875-2-yuyanghuang@google.com>
Subject: [PATCH bpf-next v2 1/2] bpf: reject BPF_PROG_QUERY with short uattr size
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BPF_PROG_QUERY writes back the 'query.revision' field unconditionally to
userspace. If userspace passes a smaller 'bpf_attr' structure (e.g. 40
bytes, which was the layout before the addition of 'query.revision'),
the kernel performs an out-of-bounds write.

Fix this by returning -EFAULT in bpf_prog_query() if the user-provided
attribute size is smaller than the offset of the 'query.revision' field.

Fixes: 120933984460 ("bpf: Implement mprog API on top of existing cgroup pr=
ogs")
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 kernel/bpf/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a3c0214ca934..c9a5415ad437 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4654,8 +4654,10 @@ static int bpf_prog_detach(const union bpf_attr *att=
r)
 #define BPF_PROG_QUERY_LAST_FIELD query.revision
=20
 static int bpf_prog_query(const union bpf_attr *attr,
-			  union bpf_attr __user *uattr)
+			  union bpf_attr __user *uattr, u32 uattr_size)
 {
+	if (uattr_size < offsetofend(union bpf_attr, query.revision))
+		return -EFAULT;
 	if (!bpf_net_capable())
 		return -EPERM;
 	if (CHECK_ATTR(BPF_PROG_QUERY))
@@ -6260,7 +6262,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr=
, unsigned int size)
 		err =3D bpf_prog_detach(&attr);
 		break;
 	case BPF_PROG_QUERY:
-		err =3D bpf_prog_query(&attr, uattr.user);
+		err =3D bpf_prog_query(&attr, uattr.user, size);
 		break;
 	case BPF_PROG_TEST_RUN:
 		err =3D bpf_prog_test_run(&attr, uattr.user);
--=20
2.54.0.823.g6e5bcc1fc9-goog

