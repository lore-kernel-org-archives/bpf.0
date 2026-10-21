Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543080;
	b=U3KrRAJszGLzGV0H/Apb/gxrJAGrZaqq86kHAbRqKLK6lnHKvejoLPMBLDKFXhyG1feM
	 h/SzZnqugdwF+gOMxO3ORJJjafvqNziCQ/HCdpoGxqTVfGWQHuthICRPbVdvEscU2LyKS
	 7LbzPZKr4ALQtBQqHrj6H2qOC0xZAhuY3B1tEeqxYgJI730zs6AfI/OtQijkol8CoQ3Hk
	 iIsitfmfr1vDwqO7nJMfhbI+UP9hWxa0gV37xV4KVl3j2aYVJLTQh56I07G82FgIlXC/9
	 7l9B4rwaMJ7FwXJkRCnWBAjB+ggXIIzfSW0/7ejnkQluvyQSfkGJnHhlXih0NZR5Dng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=9bIq9aII7kLqjsNDBEaSAqEh5ibZTVSbY4P+ooHbewY=;
	b=kHF0ebhEe3/ZsKCP9z69Y7BhoAGiOmDbjstX2odR+VsYasf2qLOoOrti+CCgwhI0b29M
	 p44Eoo6orqL7gNDWhBJNVRP+aYMFpAXkm8ZWcE+VIPtLEv/BmGQ41xjuAq3ynjbeGkvBY
	 aOMKCmmPFs+KQboXPnGc3ph8W1WedP5r73kUn4/MluKJ8VMzCGUEYZTt44k1+y/sKIR74
	 gXro9TMCB2OPr2pAdmKPTcdzQcz9SW0tRM3QKkuyQGjfnTnt5NCHrLXQEUvP464IjleCn
	 lffAVwv42CLj//RsW7UrEkXB+taAX9MzPZaClUuPJHLav9sOT1dYf6vfvc+xvfbggzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="eKFoo/LH";
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259B606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7259B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eKFoo/LH
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so81215a12.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792543080; x=1793147880; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bIq9aII7kLqjsNDBEaSAqEh5ibZTVSbY4P+ooHbewY=;
        b=eKFoo/LHGp7jtYrmLpVcXqMKP30nxaprx+ioCYxVhmS1BFT8B462AsmbkkASn0Y6Rk
         OSw6u9fIMf5DQ8L7TKRj6G4HuhTXuQkH8pRGalecuP5SnzszDOC9a7i/S7qEfvRWWxPw
         LtYxJLf5XceHQhO5HkfzQPbIDB5TM/zJtpJYqzul7MexF9oNehPOLaBu/SdJb0XpaGwa
         nRgKUb7rTwvcZesDSUKTpulwZj66VQslWm8ZjX3+GAbOajyEf9EdAHYtoGESaocrn3fQ
         D+xKIN5c6kydEivM/ibYLj5OZbPIQuX3lFTZ/FftlJf+GqDQfG3waDH6CRktFJb//hrQ
         v8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792543080; x=1793147880;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bIq9aII7kLqjsNDBEaSAqEh5ibZTVSbY4P+ooHbewY=;
        b=aGvGzZG62uFyaTfRsdwICftvcLdM4Zb4frwzl4PrRqCSu8B4iTZFFIGFAkFXoaF13e
         LKSBBFNGQm2wvAo/VryX7XTmRqJRZIqd28Tj3JpBgi7qA0sAnsCMfrEToglDvwzWCAdH
         AfPNNd51kzaDeowjF36A3L9mUDHUtdDp9g8gQqKBYirN3teuvAF3KOP6xir8cDENgnMd
         NQ9k6WPS77ye2A4AEuzWQfIE5cNbFoWsyU8EbyfsnItn99/GW+7Y/dCR1btJ0SXRg1AU
         l7HS0t78Ty8QAYq04ksOV9VOGcaJGjE2B0pTU3rJwn9VR/bkHXnDtcP6rGTrV1FjSvzi
         d86Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3zgd1SY6i2AehK/oLUAWtMbZ3urdWM1a8dra7y/NOIpxX1Q1w6cSmryCLwrf5fSQnAyw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxZt4ZIz8cEkqUAOHSkJYJSfE1usLMOztheexPCjepGPTzXgYP
	7AowKMrG7+8uyIw/snq/EA/MUqKHeqo0N0VsFok6oYNe+dSxjkP/cdnz
X-Gm-Gg: AYBFou0t+d3HPDYbrcT8D/3uW+m2Ee8GPNyejrZLMF36BKe+LWHXvQLvUDXJaHBaoaB
	kz+g3QxnfxS2LBgeSloDqEkX2AztFLXjmsOtUzcG+L0wJXz6NhsR+vw9gmFn3nqJFYON7lUaWrA
	MxXi5NAT4pAKibKz9Fx+SvkUkw715cSXrpJyaLbYSSbVtB4bGu++A2VtFhuJzcCuEnTVAG94RiJ
	EZQJpTyRbNNrlkXj7BseZ10fzROmk3nX56x4uHbaIOr/1ZD9GjSJvwi6ZRgmbj0tk1hPTNz/OxQ
	J5JlUg3iSkEKMMywCRgoHd1CUvZdZfKexeKHc+71VTvyHgljENScaw3CZhqw7AySuLE+csPJKWc
	GjsXyV1IQ14U4CGRtm4ysN+0BV0T2uDc1BAddKszk+suuOh4aHipzYY1ZGTvUUiKrugaufLVCDG
	lCbbRtNlGkukEqp4sT/5FtGup0d+GM6LHRx1UqXQr7GFemH2jspa3rrt/ql5DgmM3S4osoFvREY
	AfshZ1jTfpYL7nHvVZXmK/QBqK/DJOxPxmgVmrj6Iy7orSAqEmxFRMvb9ZcZ2z8KvsItXG7RrMy
	1SLJQ+kxWRY8VAfd7+qVpo/pt0HivUrrSST8IDoAg6j6viHDnYvBr13ChwWhcQ==
X-Received: by 2002:a17:90b:1b04:b0:3ac:9ed8:f30e with SMTP id 98e67ed59e1d1-3ad86f4e243mr274578a91.35.1792543079615;
        Tue, 20 Oct 2026 17:37:59 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813de463sm1499556a91.13.2026.10.20.17.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:37:58 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:37:58 +0000
Message-Id: <DMA3HLS1N8FF.9YVQJB6RM2A0@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Song Liu" <song@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Carry MEM_RCU for trusted fields
 with MEM_RCU parents
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261020145059.2146170-2-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com> <20261020145059.2146170-2-utilityemal77@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 07:50 AM Justin Suess <utilityemal77@gmail.com> wrote:
> An RCU-protected parent also guarantees less about the field's value
> than a trusted one. __safe_trusted promises a non-NULL field for as
> long as the parent object is valid, but RCU only keeps the parent's
> memory valid: struct file is allocated SLAB_TYPESAFE_BY_RCU, so a file
> read under RCU can be freed and reused within the same CS.

It guarantees less about the field's lifetime too. A MEM_RCU parent
only means that its memory is not freed yet, so the field is safe
only if the object it points to is RCU freed itself.
inode is. mm_struct is not, __mmdrop() does kmem_cache_free() without
a grace period. With this patch the first MEM_RCU vma hands out
vma->vm_mm as rcu_ptr_mm_struct.

That's what the __safe_rcu_or_null list is for. Let's put f_inode
there and not apply the trusted lists to a parent that is not trusted.
exe_file->f_inode is the same rcu_ptr_or_null_inode, so the tests in
patch 2 don't change, and the ternaries go away.

Something like this (compile tested only):

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01434e1..219d027 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6476,6 +6476,11 @@ BTF_TYPE_SAFE_RCU_OR_NULL(struct request_sock) {
 	struct sock *sk;
 };

+/* struct file is SLAB_TYPESAFE_BY_RCU. A reused file has f_inode == NULL. */
+BTF_TYPE_SAFE_RCU_OR_NULL(struct file) {
+	struct inode *f_inode;
+};
+
 /* full trusted: these fields are trusted even outside of RCU CS and never NULL */
 BTF_TYPE_SAFE_TRUSTED(struct bpf_iter_meta) {
 	struct seq_file *seq;
@@ -6552,6 +6557,7 @@ static bool type_is_rcu_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct sk_buff));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct request_sock));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct file));

 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_rcu_or_null");
 }
@@ -6757,10 +6763,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 *
 		 * A regular RCU-protected pointer with __rcu tag can also be deemed
 		 * trusted if we are in an RCU CS. Such pointer can be NULL.
+		 *
+		 * If the parent is not trusted, the field can't regain trusted status.
 		 */
-		if (type_is_trusted(env, reg, field_name, btf_id)) {
+		bool trusted = is_trusted_reg(env, reg);
+
+		if (trusted && type_is_trusted(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED;
-		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
+		} else if (trusted && type_is_trusted_or_null(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
 		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
 			if (type_is_rcu(env, reg, field_name, btf_id)) {

[...]

> Cc: stable@vger.kernel.org

That shouldn't go to stable.

pw-bot: cr
