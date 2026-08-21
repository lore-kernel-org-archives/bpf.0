Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765C3DA5D9
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352631; cv=none; b=DgBcg2eqwlgMb5F673yz5snplJWU7Mq1EFblROTSaGLsKuCtdLRNM6i0u3vY7FGw6bqBQrg/EGyaobWRh8Ne+cUbPkepQ6hv4RNoQESdHYLXpv1ncYLtPmqv7HckeH9g5LPNgSmJpImy6+YBAsfLHWhwZpZr5KjapL/a5etGmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352631; c=relaxed/simple;
	bh=dxQ8R6n3cVn03TYJyzIS0vykLWpC9JnE50mvu54hhJk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DK2PYhLR7do+RFzatrTY6n/NadvbHAtgx16/OxU52JkklJP0aJOSmeHGOQAoKkkvpZ42RJS/xzIN92K05bHrSVXNNZdLeXWm4IGE+cwPRE1fZXwO8NtGvyc88wsc8Rp2bRnsJDV5ki6k5dw0OcqDCIW1RxhbkqyR9cUOvLFQ1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MojyCRdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MojyCRdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A47E1F000E9;
	Fri, 21 Aug 2026 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787352628;
	bh=7nG7d4+mjBFqMZWE/31IWTtvHChdTex2FsWmFxvvZUY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MojyCRdc0Zy1vnYgb3C9mHf9VZTUqMLl1a7JHOU8+LxiEHzVd+e/abepFPFax2V5L
	 +kCQrp4Ebo7lSCjSy1rR9GTlDDlLhsDOzsStCLwwrtK91O3I3rA8Vlm2JiNK8Lrxdj
	 PD/HD+/sZRhkB7BSYSuMBn2gGyVPdBV80gUHTb5Hm1hhhWFh2halHE5MRF9BuxX7oR
	 FeG86bmqtywybBMKxYxl7xYVxueqVVIv1KaaPUuWmPPkls6N+W4IJQWVrxOeqd01qj
	 gwGpsjagdjxGR3MreRIlbG85EnUFrTxoJ4m3lycVWeXLZXvi7KR5kg/lahPheoEn/b
	 l7qkvb2AF3e1A==
Content-Type: multipart/mixed; boundary="===============7254828260068810431=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <631951b2e5dc28367e3fb9a44d942f7a3c5a64652e0457e37480b2bef84f7fe2@mail.kernel.org>
In-Reply-To: <20260821214111.1120748-6-daniel@iogearbox.net>
References: <20260821214111.1120748-6-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 05/11] selftests/bpf: Add a test for the sealed bpf keyring
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 22:50:28 +0000 (UTC)

--===============7254828260068810431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> index 0c5294738d6ce..94b57e7cdab39 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c

[ ... ]

> @@ -627,6 +630,28 @@ static void signature_bad_keyring(void)
>  	gen_loader_fixture_fini(&f);
>  }
>
> +static void bpf_keyring_sealed(void)
> +{
> +	static const __u8 junk[64] = {};
> +	struct gen_loader_fixture f;
> +	int fd;
> +
> +	if (gen_loader_fixture_init(&f) == 0) {
> +		/*
> +		 * Without bpf.keyring_unsealed=1 on the command line the bpf
> +		 * keyring is sealed empty during boot, so it is never handed
> +		 * out and a load naming it fails with -ENOKEY before the
> +		 * signature bytes are examined.
> +		 */
> +		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
> +				 sizeof(junk), BPF_KEYRING_BPF, 0);
> +		ASSERT_EQ(fd, -ENOKEY, "sealed bpf keyring rejected");

A subsystem pattern flags this as potentially concerning: the subtest is
named bpf_keyring_sealed and asserts -ENOKEY, but does -ENOKEY actually
distinguish sealing from the keyring merely being empty?

Looking at bpf_prog_verify_signature() in kernel/bpf/verifier.c, the
-ENOKEY path is taken when:

    if (!key) {
            if (attr->keyring_id == VERIFY_USE_BPF_KEYRING) {
                    verbose(env, "the bpf keyring is empty or has not been restricted\\n");
                    return -ENOKEY;

and key is NULL whenever either condition in bpf_lookup_keyring()
(kernel/bpf/keys.c) holds:

    if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
        !READ_ONCE(bpf_keyring->restrict_link))
            return NULL;

In the boot state this test exercises (bpf.keyring_unsealed unset), both
conditions are true at once: bpf_keyring_init() calls keyring_restrict() and
the keyring has zero keys. The asserted -ENOKEY is therefore produced by the
emptiness check on its own.

If the sealing under test regressed - say keyring_restrict() were dropped
from bpf_keyring_init(), or it failed and took the pr_err("cannot seal bpf
keyring") path that leaves bpf_keyring NULL - the keyring would still be
empty at boot and the load would still return -ENOKEY. Would the subtest
still pass in that case?

This is confirmed later in the series: baedf3d941d9c ("selftests/bpf: Add
tests for bpf keyring in signed loader") adds bpf_keyring_provisioned(),
which enrolls a key and then asserts -ENOKEY with the message "unrestricted
keyring still not consulted" - a populated-but-unrestricted keyring yields
the same errno this subtest asserts for an empty-and-restricted one.

The subtest does verify the keyring_id routing: without the
VERIFY_USE_BPF_KEYRING special case, keyring_id 3 would return -EINVAL
instead, so -ENOKEY vs -EINVAL is a real distinction. The question is
whether the sealing aspect of the name is fully backed by what the kernel
path actually checks.

Would renaming the subtest and assert message to describe what is checked
(an unprovisioned bpf keyring is never handed out) rather than the sealing
mechanism avoid claiming more than the -ENOKEY assertion verifies, or should
the sealing claim be left to bpf_keyring_provisioned() which separates the
two conditions?

> +		if (fd >= 0)
> +			close(fd);
> +	}
> +	gen_loader_fixture_fini(&f);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32530917987
--===============7254828260068810431==--
