Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D140149D
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463866; cv=none; b=ZK6QGjIv6rpILMtZcGlci+oaaFaF0ndI8G0raW8ApBV+IqVtv5imgwW9f1oo4dt3tB3sapnPxV+xwj9b/WmxovMgpTbWA4ipNXXVr+D84DFuJ+GWbN+WSswQtN4mYGrD+DkSxVtzEBJ9DJ8sC8SMipkJDJBIPIXBGpnAt3MD9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463866; c=relaxed/simple;
	bh=/n9d+NC8JOM19qYu10Vbdt4z3rtQyN0QXnMlGzk4p90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic2bhTOD8hMCQVdhfz1dhKRvKePWNDi2QwDToO6uLZFj//rTZAYTEWWu5prsxepMVRX8p7R00f4ExEdNlM5wZog+8f8ZMdEY0MRkcroXhwGia25wM2z/vw+ZzCex7dL/aNOFEBXYJiMiJxn/0ttqk7kwNkI2BQMdOGrK7DzbpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g/UrCEWD; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g/UrCEWD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772463861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxXd5uD0uoa/0anu8jDjtKQ562RChNx+PmdQxbvuGhg=;
	b=g/UrCEWDihyVXhzbUUFgZDqU5+P5cl0s3zn3IK3c57D2uxsc+EFVmvxytaNjKhHUyB3UwQ
	r19TQm1aJb87/7V3FW9ABOUha23OQO6YNbWaMOYE4WOQhN+ZQmyeGqcEkk7HjCDAXeArqW
	5+WU0ZrqDufY+//61CFpNNTu3F2alN8=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 1/6] bpf: Add fsession to verbose log in check_get_func_ip()
Date: Mon,  2 Mar 2026 23:03:37 +0800
Message-ID: <20260302150342.55709-2-leon.hwang@linux.dev>
In-Reply-To: <20260302150342.55709-1-leon.hwang@linux.dev>
References: <20260302150342.55709-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since bpf_get_func_ip() is supported for fsession, add fsession to the
verbose log message in check_get_func_ip().

No functional change intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc4ccd1de569..636836a315b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11493,7 +11493,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 
 	if (type == BPF_PROG_TYPE_TRACING) {
 		if (!bpf_prog_has_trampoline(env->prog)) {
-			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
+			verbose(env, "func %s#%d supported only for fentry/fexit/fsession/fmod_ret programs\n",
 				func_id_name(func_id), func_id);
 			return -ENOTSUPP;
 		}
-- 
2.52.0

