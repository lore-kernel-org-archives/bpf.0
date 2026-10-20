Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521176;
	b=A3Uo/DaHBeN0P0gEcrC664+moixJ+KS3Te3+BeQb6FCClWHtryH0BXKPJ4pKl0pTm0x6
	 FzfxoVI8qa7lVc+aE+xU+i5/0IGFflEGwldoq94sqJhT8ZQkCOaq/+X+Qa8g9B5hzZl2j
	 ignLNWvziJMPvrBpcV2BdfJG8w59iNVfdaPOOLDTGiAsIB5FPAQBbGJtT5oEzhBDspPzV
	 fcCIlaALYy7zwjDMxXdS1CPM1sc3IJrxuI5y0bdFp7bTebIFpP7obo+vN4uM0wC47+DtI
	 qZTetD8F90vQq6O45/IGthVfT/70D5Dz8uxJn1wZJwqraKZKis06R9wSlzp/n17ndMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521176;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VVpuWYwkWD/9/HNw8SQdi33UO4JldlQknYGbD5fRVbE=;
	b=DOzxY+qBVPs/+h5tb0gQwXmzuMCe1VSlVWWiX4i4kwIzgY+Z6EqHit+GHpzGUxni775H
	 Q/8mZ4LUMCGDYLAwN0knqVpuDlM+eoqnKPQDYLhbkpO6v8tqxr1uDxFnPlTed4oKIHYbb
	 eGcR+DFQFah6J+d25pzKnJYxZRjCXB9WfR6UOjxBqqrcUEi0RnAe62pu02D6qkO5XvPGp
	 q0RizJXx2X3ENmO0VI8MqU3pegJFRfm5vgOO/Xjea9JKCOD4Gkknu+25KA6tU9tVzVmf3
	 QDr9DjOFETyEXC0mABHQYnY7Q6JiNom19VsPk4JQFDKkFgmIyfQijfF+65eFwDSeA6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eiFDJWYL;
	arc=none smtp.remote-ip=95.215.58.218
Received: from mta1.migadu.com (out-218.mta1.migadu.com [95.215.58.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620A606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0620A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eiFDJWYL
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZaL8y2eN1FweU55DX6zD7cbfGbNsVefal33JOq2RRQY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792521173; v=1; x=1793125973;
 b=eiFDJWYLuxc1mV1IP/6Y8R94SNfhTmenqK8tTKp0K2hezy4gu/ZrXgBdJAADVVtEFhB75pvP
 zN6s7N5vafqm5BmR9EdKwQu+tB/WK88I+7VsREfiEkOMTrB9BFv9jjg2JsNnvATwOHqNPSldGji
 jOJUmvJ2cG3PBQTmcftZ9xdU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e1178afebfa25aa;
	Tue, 20 Oct 2026 18:32:53 +0000
X-Mizu-Trace-ID: 2e1178afebfa25aa
X-Migadu-Flow: FLOW_OUT
Message-ID: <d2369629-846e-4fd8-b567-a0fd8863256c@linux.dev>
Date: Tue, 20 Oct 2026 11:32:48 -0700
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
Subject: Re: [PATCH bpf-next v2 00/11] bpf: Scope callback arguments to their
 frame
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Nicholas Carlini <npc@anthropic.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
 <DM6EVHTVM3IR.3RCFLKV9WC80J@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DM6EVHTVM3IR.3RCFLKV9WC80J@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 9:42 AM, Alexei Starovoitov wrote:
> On Fri, Oct 09, 2026 at 01:27 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> Introduce REF_TYPE_FRAME for this use case: a reference owned by a
>> callee frame, dropped when the frame is popped. Tie each argument to
>> this reference so callback return invalidates it and its descendants.
> 
> Another idea...
> The id is owned by the frame. Can we keep it in bpf_func_state
> like diag_frame_id ?
> release_reference() already takes ids that are not in refs[].
> See unmark_stack_slots_dynptr().
> Clones copy parent_id and slices hang off dynptr's id, so both are
> reached.

Slices are not reached. A slice's parent_id is the dynptr id, and the
walk from frame_id finds that id only while the dynptr is still in a
register or a stack slot. R1 is caller-saved, so the bpf_dynptr_data()
call that creates the slice usually clobbers it.

This can be fixed in your diff with:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc12df55d2e2..57859c3baeeb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11470,6 +11470,7 @@ void mark_frame_scoped_arg(struct bpf_verifier_env *env, struct bpf_func_state *
 {
 	if (!callee->frame_id)
 		callee->frame_id = ++env->id_gen;
+	callee->regs[regno].id = callee->frame_id;
 	callee->regs[regno].parent_id = callee->frame_id;
 }
 
i.e. the reg is its own parent again.


> All setters have callee already, so no need for patches 1-3,
> REF_TYPE_FRAME, frameno in refs[], the reg that is its own parent, etc.

I don't quite understand the concern with the series as is.
I'm guessing a new weird REF_TYPE in refs[] which is not an actual
acquirable object gives an ick. Or is it the plumbing?
I take it you agree that we need some kind of frame-tied lifetime
tracking, right?

I added some refactoring patches in attempt to avoid growing
bpf_func_state vs v1 (Eduard mentioned we create a lot of these
objects), and that is what you've just suggested.

frame_id approach is fine with me, just want to understand the choices
we are making.

Thanks!

> [...]
