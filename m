Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074382;
	b=eI/YVAB9i1/sdIpeNBVokhE3rOLopPCCd6fboFrMtkUy5IfQsR8plFIF5qICoV1oC2ce
	 1RojFr/HwZt8c6f3W+hR+K2LKMhyhjHrfDitm0o5bp66e7PImNsauQZNlEdxCsZvlD8CG
	 R1SgvU2NOSVs5pGuLkFTJ2lUr6Fj7dkmPy+K/fsk6/Oc6CTMp40stTPb1Fi9x+F7YAWf+
	 R1pmFSJcz1bIwK4j36XH0JEc1ZtdrTZR/m8o1J0Cy0setg88kxDU8wGIJOk4JgxbkU/6P
	 VxWd5uyNqisxTkPvDIPfLr3PFePC/sIkAbxaZnTFxzMCZmQRtISribV/EhXH/gNIi/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074382;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HGNBZg04KAZeZlrv62ywxVBlGQjVP9azSckK49EmwII=;
	b=URQg/a/QTsD7rnCxTNcvrT+y/JYqW3DiSBfqa95ZYiBV/1FWZq48rsyRAWcQ4vzf2KFd
	 HWsQ0H8aeQez4TRA5goCJfzS9IDavNkZLi1yaRx9e7PlGVn1BaKAIf/sJ617OTHdhUF8f
	 r545aFJXC7YQ/tUvMlNWnRStYWiHkaS/GClLXeEUvzPoB/5w3o+EAjSnUAcPWf9/SA4ZS
	 CxqPuFY4q8wKkxVZsDhbERAoqd/aI9GE5EzGKjJ/F0lylUU+m+WpcRvFN6iBElcn4uQBS
	 X+f5F1+4GQ1BrfqNuSNKKiThNalieFgbHK5e/dqlpBJEIztHpFxVRMRMf85M0oDcNGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=j8v7OvK0;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F8606A326;
	Sat,  7 Nov 2026 17:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 871F8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=j8v7OvK0
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhN-007j5t-LV; Sat, 07 Nov 2026 18:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=HGNBZg04KAZeZlrv62ywxVBlGQjVP9azSckK49EmwII=; b=j8v7OvK0njXYWBtd/wFwp+SE7n
	/3R1aIgEO0qFBEqD0gdCWDWcKEv+0AcIzVwSgQeM3JeOgdUUW49mBlCMbZ50u/RKhDxQ/swi9HSvr
	W3B7YKHMCWbjNvjsRtmsh6+Kianj9O2Sjofjsw1fIpGV627oBa2xwgmam+s15szb2nC8eUpgJE8vS
	o2hqBy2me5iEOfgkztAJkIaE5JP66wPDTE2xoErpX5edR2ZhPYAE/zRbRFfAgpfoC9yHvtAGojbDg
	LD46T/hfy2q74rAVDrtE9p42jPY8D5QwAiC5uEnbEQxDWrX7rRQtReFLBFg/kZh5S1zhNiaZJl+iD
	u3BDMDgQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhD-0006IH-9I; Sat, 07 Nov 2026 18:59:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkh1-007LnK-VQ;
	Sat, 07 Nov 2026 18:59:08 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:24 +0100
Subject: [PATCH bpf-next v3 2/8] bpf, sockmap: Restrict iter-context
 sockmap updates to iter/sockmap
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-sockmap-update-limit-iter-v3-2-7c0bad1ad036@rbox.co>
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

Among tracing progs, allow only iter/sockmap to update sockmaps and
sockhashes. Previously, any BPF_TRACE_ITER program could perform these
updates, which caused locking issues in specific scenarios [1][2][3]. This
tightening is part of the broader effort to lock down the BPF API [4].

[1]: commit 4d328dd69538 ("bpf, sockmap: Fix af_unix iter deadlock")
[2]: commit 64c2f93fc325 ("bpf, sockmap: Take state lock for af_unix iter")
[3]: https://msgid.link/87echn2fhd.fsf@cloudflare.com
[4]: https://msgid.link/akRZ_e7DJh2aP-2i@john-p8

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
I was tempted to define BTF_ID_LIST_SINGLE(bpf_iter_sockmap_id, func,
bpf_iter_sockmap) and just compare against env->prog->aux->attach_btf_id,
but a single line BTF_ID_LIST_SINGLE quickly turned into a 6-line
ifdef-CONFIG_NET-fery, so I've sticked with strcmp().
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09a44723bb2e..e784e4a1e5f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10543,6 +10543,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 {
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
+	const char *afname = env->prog->aux->attach_func_name;
 
 	if (func_id != BPF_FUNC_map_update_elem &&
 	    func_id != BPF_FUNC_map_delete_elem)
@@ -10553,7 +10554,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	 */
 	switch (type) {
 	case BPF_PROG_TYPE_TRACING:
-		if (eatype == BPF_TRACE_ITER)
+		if (eatype == BPF_TRACE_ITER &&
+		    !strcmp(afname + strlen(BPF_ITER_FUNC_PREFIX), "sockmap"))
 			return true;
 		break;
 	case BPF_PROG_TYPE_SOCK_OPS:

-- 
2.56.0

