Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FCD37AA63
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178176; cv=none; b=WOYv+ZcK5aySrOA71twKZc3psspamLU5W608Cp4IaKyQD6+iWNQ0pC1X15ZMG0p/kQx0/5NCIaH/A0OEGB6Ikcj238zeH1Y8BkwDzQNV0JbmggJYbExA/jQsj3hk9KYNPtoXaJrULjf0J8voWWh7hzrbSl8fYlx5k00UjloWe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178176; c=relaxed/simple;
	bh=7AeWU/YvqQF1PzEbyIyX0Xm/9Qgbqi4ptlcPxsVDmoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZURLSzaaNwegrgVphaXcvFhIHPVZzc5rZIW6lIPbuC1WMrt0YkJLvQgTSocCYvR0a5PACKGF9ACxdYWKdkP6SYP8Gr0qjGCYCeX55EasrPGfGU9z81IG25KUFyLgJKfzsjRqodJeCxVoBQjtRz3/KVp2MVqkKavdiOFxESdYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTO1zsR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTO1zsR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0722B1F0089F;
	Thu, 11 Jun 2026 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178174;
	bh=q/sR1od44JgQMbXMM22aNq/uCPCFhrtr/V2T29hwrGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTO1zsR5Q3CeDbWHYJkGNaFC4K7A5vtRg2oTCMEu89w5p1OxGM5AhPTJ1Eshiw6vk
	 1WlnpdbW3fn6kJuqwWkNkWXlKzbHFV3HB64Rwqgl1KVuOjIuInbjDCIT8aWiqeRBbR
	 BIH8ArQRw4OXKqX3DutFYRYXPn8yALCji2DYS0gM7DxVVNT2RsR0cW0OHLH7P5NSIo
	 AUxqCH+pF6EyZjyxMfVFdc/mAXDIWyiFRt+SXMP9IOnjsflIpuEtrT0THwb1Wu1ARq
	 f91KCWTMiDGuWBlNPvNmyplStbBxx8TuQh8XZQzcEbGuxJXndlmrl4fxQurlIuONfD
	 Q/nrvRr5goksQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv3 bpf-next 2/7] bpf: Use user_path_at for path resolution in uprobe_multi
Date: Thu, 11 Jun 2026 13:42:25 +0200
Message-ID: <20260611114230.950379-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611114230.950379-1-jolsa@kernel.org>
References: <20260611114230.950379-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve the uprobe_multi user path with user_path_at() instead of copying
the string with strndup_user() and passing it to kern_path(). This removes
the temporary allocation and keeps the lookup logic in one helper.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b5a12af2d3f8..f8990bc6b64c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3227,7 +3227,6 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	unsigned long size;
 	u32 flags, cnt, i;
 	struct path path;
-	char *name;
 	pid_t pid;
 	int err;
 
@@ -3272,14 +3271,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	    !access_ok(ucookies, size))
 		return -EFAULT;
 
-	name = strndup_user(upath, PATH_MAX);
-	if (IS_ERR(name)) {
-		err = PTR_ERR(name);
-		return err;
-	}
-
-	err = kern_path(name, LOOKUP_FOLLOW, &path);
-	kfree(name);
+	err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
 	if (err)
 		return err;
 
-- 
2.54.0

