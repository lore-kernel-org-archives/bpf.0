Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B091DDC37;
	Sat, 14 Feb 2026 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771045694; cv=none; b=S3LzLod17RkZ+Jt/LNYwyrf/obSf5g6TRbdw88GVVQFNgSjzk4SmUv2R4cpw47Gukf5uiXPsaBA2KTMw41mlvW8m5jTDo9cQ54WWa7wQkQoiFrK4H6j8TxPaH4s3shhyJ63dNexOxQwvnuAhAErRMGB/zaA0s8avCTlHhdTknJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771045694; c=relaxed/simple;
	bh=cG9lVPnYSpbBWu/gq0zqn+bklzX5Z7JBWWyEOC+3fV4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XSRXgnxyHqLUPCyBe8Mw1R0qF1uPMgW4mIrZ53E2RSeYZ6pSt/izPL90kFcxz/AVaeB3MCQzUTgLsVHuzSzVmxBypzUxOSvD3j4P6Xu1/d8dmRpL0GnNad7bSiWXdvFDBglWxE4E2tjFzSJNzskLrYl8RZ6mqnFttR4mQ90Nh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgwICbvZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgwICbvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1BFC19421;
	Sat, 14 Feb 2026 05:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771045693;
	bh=cG9lVPnYSpbBWu/gq0zqn+bklzX5Z7JBWWyEOC+3fV4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZgwICbvZ971Uq5lYSKBCoAbYqHWeHohO94elNZqukipVvcdhBTb+L3rnM19LbmTnG
	 07/eBcVtFfX2AXXb4tMLALUa1Cao10rheXUIfiANTCTtJX9p2xXkyPnH4qUUNRwYY4
	 AuuDogJg8fyDRR/6ZGBG49fineBSRanhKzi8h6KsEs4JfG/KYcLO/NMbboOjh+IkBf
	 DYgquEMUFxsvSG3qTsx0F5JOLi7rSHbvRYAC4FnVhv0klu7yCULBIoq2TIgDutzoMj
	 nZrWIwUrZdEzVWjVBiFpouGfLt5RFANFlwXn6o/LWhydINtqujdUvjPaqvb4eKfFrT
	 QEkcFcEB+VsBA==
Content-Type: multipart/mixed; boundary="===============8914052136563185622=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0c7639f60a2a769bee6ea3c211ba98515ddec243d7ab97feae8453b2636e299@mail.kernel.org>
In-Reply-To: <20260214044155.38820-1-pilgrimtao@gmail.com>
References: <20260214044155.38820-1-pilgrimtao@gmail.com>
Subject: Re: [PATCH v7 4/5] bpf: allow using bpf_kptr_xchg even if the MEM_RCU flag is set
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 14 Feb 2026 05:08:13 +0000 (UTC)

--===============8914052136563185622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9300,6 +9300,7 @@
>  		PTR_TO_BTF_ID | MEM_PERCPU,
>  		PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU,
>  		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,
> +		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU,
>  	}
>  };

Was the new type added to the correct array?  This hunk adds the entry
to percpu_btf_ptr_types, which backs ARG_PTR_TO_PERCPU_BTF_ID in
compatible_reg_types[].  That array is used by bpf_per_cpu_ptr and
bpf_this_cpu_ptr, not by bpf_kptr_xchg.

For bpf_kptr_xchg arg1 (ARG_KPTR_XCHG_DEST), the verifier looks up
kptr_xchg_dest_types instead:

kernel/bpf/verifier.c:check_reg_type() {
    ...
    compatible = compatible_reg_types[base_type(arg_type)];
    ...
    for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
        expected = compatible->types[i];
        ...
        if (type == expected)
            goto found;
    }
    ...
    return -EACCES;

kptr_xchg_dest_types currently contains only:

static const struct bpf_reg_types kptr_xchg_dest_types = {
    .types = {
        PTR_TO_MAP_VALUE,
        PTR_TO_BTF_ID | MEM_ALLOC,
        PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
    }
};

A register with PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU will
not match any of these entries, so check_reg_type() returns -EACCES
before ever reaching the found: label and the switch statement below.

It looks like the entry should be added to kptr_xchg_dest_types rather
than percpu_btf_ptr_types.  Alexei made the same suggestion on v6 of
this series:

https://lore.kernel.org/bpf/CAADnVQJdwqeoqi+mPjQjmNbUqz2RxAjq-dVsGb7c_MCqpqmwhA@mail.gmail.com/

> @@ -9475,6 +9476,7 @@
>  	case PTR_TO_BTF_ID | MEM_ALLOC:
>  	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
>  	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
> +	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
>  		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
>  		    meta->func_id != BPF_FUNC_kptr_xchg) {

This switch case is correct, but it can only be reached via the found:
label after the type-matching loop succeeds.  Since the first hunk
adds the type to the wrong array, the loop never matches for
bpf_kptr_xchg and this case is unreachable for its intended purpose.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22011467184

AI-authorship-score: low
AI-authorship-explanation: The patch went through 7 revisions on the mailing list with human reviewer interaction, and the type of mistake (adding to the wrong array) is characteristic of human error in a codebase with many similarly structured type arrays.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: The new type was added to percpu_btf_ptr_types instead of kptr_xchg_dest_types, so the patch does not achieve its stated goal of allowing bpf_kptr_xchg on MEM_RCU pointers; there is no user-visible crash or security issue, but the feature is silently broken.

--===============8914052136563185622==--
