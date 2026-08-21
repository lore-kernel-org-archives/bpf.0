Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72B2D8762
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351962; cv=none; b=dJTQrARtjYlkGYTHGOpY8zmBDEMH6Plr79r7/AiTBOFaaJYff8JiUOyi6YqngMO2RxMdPzwDoKQhjcpkgXL3Het6OkWw7CM8fvdWiXm2s3TY9zNrWppkBmc3w8MP+7l0ACc50RFuElqhehjLZf8chezOu0I+v7yYnu8i/zCs/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351962; c=relaxed/simple;
	bh=jls0K9yPW+sZE/aF9oF46wDzfKtNTas1qJc4Id7SU64=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NfnIOPWAky+JF1LfAJ9fE3CIuvzrNxd0/D4heZChgpNtKUFGuBqc+d9JA4FAIWSgiJT6JiGrzsFvUu56Qk5m9zdnZUh3E7ncuuUx5vV5cfS+5szPetwTs8/sYvkLJee3gaCNYqjSnWIZ+OLR3PZ7j/FE3t7sffD+YPcnZtexcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxC/S53Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxC/S53Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8E81F000E9;
	Fri, 21 Aug 2026 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787351961;
	bh=31f93K0GjS1NzUEsskla3Vr44FOvFi0dEKjXtpSnwqQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VxC/S53QYCZUtyvg+1C0tq59ZGnBvfLXNilxJmKdjFHhTbVKGtUSthcNjIzHI2G0Q
	 fcquqAGpcPdxOKRlmrdkdbe9P/A3NwKvLP8VkTCl/n47GA8JEeymas3wx4KXF+YlO3
	 hwMGmiQ8XNuQIYxC9dLbD7cxRWL7l1he9P5WO6qHQv9IaausCuuwRfjr0xHloRsFEA
	 GyT3PUMHl1Aw6UH3y7tdioexrXjBVDD5FY5kJoCbUEmg2PSic8aG6xbMdBoIF729RZ
	 1TO3DMB8GtJPtCne7uE1BUWYWiuiPaYmXV31k+GJrYjAOVvqmSyPg6oLIRy++jgN1+
	 t2Yc0GuMZTCKQ==
Content-Type: multipart/mixed; boundary="===============5352316445685369862=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ce043a0ddba85ed13a453c267805d23ace206cc0768ff2e8da898e426702fe71@mail.kernel.org>
In-Reply-To: <20260821214111.1120748-3-daniel@iogearbox.net>
References: <20260821214111.1120748-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 02/11] bpf: Refuse caller-supplied keyrings when the bpf one is active
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 22:39:20 +0000 (UTC)

--===============5352316445685369862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2beb61092bb31..543f245cc2557 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -673,6 +673,13 @@ Kernel parameters
>  			keys. Once the keyring is restricted it becomes active
>  			and can be used for BPF program signature verification.
>
> +			Setting this also means that the bpf keyring is the
> +			only keyring a loader may select for the rest of the
> +			boot: caller-supplied user/session keyrings are
> +			refused with -EPERM, whether or not provisioning
> +			actually completed. Leaving it unset keeps the prior
> +			behaviour, where a caller-supplied keyring is allowed.
> +

Is this paragraph accurate? It states the bpf keyring is "the only
keyring a loader may select" but the implementation allows system
keyrings to remain selectable:

kernel/bpf/verifier.c:bpf_prog_verify_signature() {
    if (!system_keyring_id_check(attr->keyring_id)) {
            key = bpf_lookup_system_key(attr->keyring_id);
    } else {
            if (attr->keyring_id != VERIFY_USE_BPF_KEYRING) {
                    if (bpf_keyring_enforced()) {
                            verbose(env, "caller-supplied keyring refused, use bpf keyring\n");
                            return -EPERM;
                    }
                    key = bpf_lookup_user_key(attr->keyring_id, 0);
            } else {
                    key = bpf_lookup_keyring();
            }
    }
}

system_keyring_id_check() accepts keyring_id values 0 (builtin), 1
(secondary), and 2 (platform), so a loader can still pass any of those
three ids and succeed. Only the user/session branch is refused.

The paragraph's lead-in sentence describes a stronger guarantee ("the only
keyring") than the code provides, while the clause after the colon correctly
describes the narrower behaviour ("caller-supplied user/session keyrings are
refused"). This is the text an operator reads when deciding their boot-time
trust configuration.

The more accurate phrasing appears in Documentation/bpf/signing.rst added
later in the series, which states "the only non-system keyring a loader may
select" and "The system keyrings stay selectable."

Could kernel-parameters.txt use the same "non-system keyring" qualifier?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3be8d51d35ac4..a93a8dc427d8c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21018,21 +21018,28 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
>  	if (!attr->signature_size ||
>  	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
>  		return -EINVAL;
> -	if (attr->keyring_id == VERIFY_USE_BPF_KEYRING) {
> -		key = bpf_lookup_keyring();
> -		if (!key) {
> -			verbose(env, "the bpf keyring is empty or has not been restricted\n");
> -			return -ENOKEY;
> -		}
> -	} else if (system_keyring_id_check(attr->keyring_id) == 0) {
> +	if (!system_keyring_id_check(attr->keyring_id)) {
>  		key = bpf_lookup_system_key(attr->keyring_id);
>  	} else {
> -		key = bpf_lookup_user_key(attr->keyring_id, 0);
> +		if (attr->keyring_id != VERIFY_USE_BPF_KEYRING) {
> +			if (bpf_keyring_enforced()) {
> +				verbose(env, "caller-supplied keyring refused, use bpf keyring\n");
> +				return -EPERM;
> +			}
> +			key = bpf_lookup_user_key(attr->keyring_id, 0);
> +		} else {
> +			key = bpf_lookup_keyring();
> +		}
>  	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32530917987
--===============5352316445685369862==--
