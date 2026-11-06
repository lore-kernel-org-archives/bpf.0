Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007946;
	b=QgxoDOVPDf/iA/ouPbs6qgleazViHYGeOnFi3ytBEFjuvO2H5ZgWF7q9KqfT0YGn0m4A
	 Pg25lEpi6lG41G6yUPqSA/18kbjG4Hs21ZGmFxxpDpGxYemsCa0KDtyRH/+ASPpxj6Ev7
	 Uyc+rEHhJkp8uE4kiJE/zltBExhymfeQyoRsjM3UOZjcIh9aj0YnSLcMI1USj8gHmRdGJ
	 ATTQkHl5NdGf8VQdaDLMh978SFa9laXSmmbZpZXvgj10r6tM48CasI9Z0KCVK1/PYXgWm
	 WPzrG0yxxl/6b9zI8vhHpw0445V1kG8Lnyqt7Pry7gf0OlaOuB2rN1RQ3hJn5hiUqcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007946;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3PSRJAyzJjXTa91c20Ghv5zF6aqkJV/QWmUyUDslx4s=;
	b=LQYOMm9U9HQkeeusnv4oIRTYTj6ta/FCc0KTKNscFLqk75R3OI6F0SHgFZuTWoUaa+pO
	 SiptMRksH7eYDS2SGPFnp+tIKvDkGnysjwT9NhnwxTQm8c66iPSmbJ4xgGf6cQciy//fv
	 mWJm4cli74mGMO2IFyLIczI9TC4Grt54NIVSiwucHCvEq8QV39VYye0DK+K7AAv5v1Eq+
	 nzoqrUKNNXmjBiGSaQxrRWestZ8QXYVHDCAkAtj3GBrjr9hXTpKxHj5HwA3389qnEoYUf
	 l1NQEUtg5SuI3bbEYJ+q79RmqKf2AYpbn9+PfsQjNDVpm5sbWHwHKoiuf6vOP1YHsIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w20Nyvub;
	arc=none smtp.remote-ip=91.218.175.145
Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39717606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39717606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w20Nyvub
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z2txFjSrT7htQrPD/Z0Mmx5hKSX2xlJyM5Bx1Cc6DUA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794007941; v=1; x=1794612741;
 b=w20Nyvub3XWEAW5gfIgLhNaMRbDGc0Rcvf3uiFC/gL+BrwaBNmaFFp4cJJjePeEHACrdp6sW
 KpKnsDw8n/Y+4pmKskh2G1z2PQxzatb/ElNf8NFl+LILbTtVDnB91X/S7NR6PvfTiTfkdtB4g52
 6i8o8PlnPLenW3dqsFuQNE1Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 69da4acccb4a837c;
	Fri, 06 Nov 2026 23:32:21 +0000
X-Mizu-Trace-ID: 69da4acccb4a837c
X-Migadu-Flow: FLOW_OUT
Message-ID: <2785198b-ca41-4cee-9dba-bc0c1e6e8f25@linux.dev>
Date: Fri, 6 Nov 2026 16:32:15 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 0/4] bpf: Scope callback arguments to their frame
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Nicholas Carlini <npc@anthropic.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 4:11 PM, Ihor Solodrai wrote:
> [...]
> 
> Ihor Solodrai (4):
>   bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
>   selftests/bpf: Cover the user ringbuf callback dynptr lifetime
>   bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
>   selftests/bpf: Cover callback-frame map key lifetime

Alexei, if this lands first, your pending verifier rewrite will need a
hunk like the one pasted below. Or the other way around.

Without it, a join can link a value to the wrong callback frame.

diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index cc4494aef187..92b94e18c873 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -464,6 +464,9 @@ static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
 			return false;
 		if (!join_loop_stack(fa, fb))
 			return false;
+		jid_note(js, fa->frame_id, fb->frame_id, true);
+	} else if (!jid_strict_ok(js, fa->frame_id, fb->frame_id)) {
+		return false;
 	}
 
 	for (i = 0; i < MAX_BPF_REG; i++) {

> 
>  include/linux/bpf.h                           |   2 +
>  include/linux/bpf_verifier.h                  |   2 +
>  kernel/bpf/arraymap.c                         |  19 ++-
>  kernel/bpf/states.c                           |   3 +
>  kernel/bpf/verifier.c                         |  16 +++
>  .../selftests/bpf/progs/user_ringbuf_fail.c   | 135 ++++++++++++++++++
>  .../bpf/progs/verifier_iterating_callbacks.c  |  91 ++++++++++++
>  7 files changed, 266 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 475a0cfd02f14d764023e926ac01fc7597134229

