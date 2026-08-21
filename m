Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E343002B3
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351966; cv=none; b=JXTLIWTSkR+c0lUz87sAlfJo7XFY+WKqu4yjHqyupe8Kzg9D26KQonD0fVz6uBSSZP20cRlGkFVSBC7eewkgbMTsklYnUQQyMyZSTYNsIVfG7yIhAtfq9orHv+i2NyK5Ik5GwICP+aUKYQEM8I40zXN4M25bWV7CYViyrnfIrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351966; c=relaxed/simple;
	bh=d6iSPjMftVulHtiTlfJ35mSo52k39HKaAEXS8IgE2ng=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kSN8Qnm3wsWCxW+ittCgn0mcnXlk3WQw2PFMBwItdMfpRJDQ9v4KNB2E2YJqdnWm1H7RmA9tZKUkxBRG13SNbE/Xz8brDJqGuLUgZvncn811U04ASxIWrzpsFOpAiycM9B3rewDD4zG8qhy7ku/r9tSVN4ONgFLjdxuw6QPwzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQZDElSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQZDElSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA061F000E9;
	Fri, 21 Aug 2026 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787351964;
	bh=MCAxI20xzkj4HaPL1EuC9MVrk3aLTDZ8q6mnvt+nWuk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nQZDElSke0UwGLKrfqh3glu4C+HKF00kAjnZ8E19ITBwWZ6lbSfyy0WtPljwroL3B
	 sfrVE0EgJX+Dj5zXGaoFDeaApOSmggMU3ZpsAMiRA0M9plMdDkVdX6Dc/EZ8s0/xQw
	 MbleNdFkCMqricSO5qi5BNq9Rq9n3v+a96o4bPjOnNTH+tzpBePqC2E/S0cos1xi9a
	 /Kilszuemo6af2ij+ybNuLqX7X7A4fiMOH1Y6tT5sdidi92WP4Bw85+gyvT9jU/LNA
	 i4vGrs2niBR+PWdDDEsb88fcwenwADq/ffFQTfqRd0zHA3Lh5PE5L/PwtwmL9SKPfA
	 T0+U7sZ4wJvlg==
Content-Type: multipart/mixed; boundary="===============8728225314386077632=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <531959923e7157df026710ecfec99782ad4a7483697883ea4043c582b837ee59@mail.kernel.org>
In-Reply-To: <20260821214111.1120748-9-daniel@iogearbox.net>
References: <20260821214111.1120748-9-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 08/11] selftests/bpf: Add an end-to-end ML-DSA signed loader test
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 22:39:24 +0000 (UTC)

--===============8728225314386077632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index ea7044f30adc3..4e6d13dbf2662 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -51,6 +51,7 @@ CONFIG_IPV6_SEG6_LWTUNNEL=y
>  CONFIG_IPV6_SIT=y
>  CONFIG_IPV6_TUNNEL=y
>  CONFIG_KEYS=y
> +CONFIG_CRYPTO_MLDSA=y
>  CONFIG_LIRC=y
>  CONFIG_LIVEPATCH=y
>  CONFIG_LWTUNNEL=y

Does this fragment need CONFIG_CRYPTO_SHA512=y alongside
CONFIG_CRYPTO_MLDSA?

mldsa_signed_load() signs with sign_buf_digest(..., "sha512"), so the
PKCS#7 blob carries signedAttrs with a SHA-512 messageDigest. On the
kernel side pkcs7_digest() takes the 'sinfo->authattrs' path and does:

    tfm = crypto_alloc_shash(sinfo->sig->hash_algo, 0, 0);
    if (IS_ERR(tfm))
        return (PTR_ERR(tfm) == -ENOENT) ? -ENOPKG : PTR_ERR(tfm);

Without CRYPTO_SHA512 that returns -ENOPKG and the load fails. It happens
to work today: the fragment has CONFIG_MODULE_SIG=y and the module-signing
default choice selects CRYPTO_SHA512, so the dependency is satisfied only
as a side effect of an unrelated option's default. It would break silently
if that default or CONFIG_MODULE_SIG ever changed. The file already lists
the RSA path's digest explicitly (CONFIG_CRYPTO_SHA256=y at line 15), so
an explicit CONFIG_CRYPTO_SHA512=y here would match the file's own
convention.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> index 4b2416903d90d..a1fa1c37815bf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c

[ ... ]

> @@ -1550,6 +1563,87 @@ static void loadtime_with_map(void)
>  	test_signed_loader_map__destroy(skel);
>  }
>
> +/*
> + * End-to-end signed load with a post-quantum key. ML-DSA (FIPS-204) is wired
> + * through the X.509 and PKCS#7 parsers, and BPF reaches them via
> + * verify_pkcs7_signature() without knowing the algorithm, so an ML-DSA key in
> + * the keyring should verify an ML-DSA signed program with no BPF-side work.
> + */
> +static void mldsa_signed_load(void)
> +{
> +	char dir_tmpl[] = "/tmp/bpfmldsaXXXXXX";
> +	int map_fd = -1, prog_fd = -1, err;
> +	__u8 *sig = NULL, *buf = NULL;
> +	struct gen_loader_fixture f;
> +	bool have_fixture = false;
> +	__u32 sig_sz = 16384;
> +	char *dir;
> +
> +	dir = mkdtemp(dir_tmpl);
> +	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
> +		return;
> +
> +	err = run_setup("setup-mldsa", dir);
> +	if (err == SETUP_SKIP) {

Should mldsa_signed_load() create a session keyring before running
verify_sig_setup.sh?

Every other subtest in this file that calls run_setup() and then loads
with KEY_SPEC_SESSION_KEYRING first does:

    syscall(__NR_request_key, "keyring", "_uid.0", NULL,
            KEY_SPEC_SESSION_KEYRING);
    dir = mkdtemp(dir_tmpl);

Nine sites, one per setup-rsa user. prog_tests/verify_pkcs7_sig.c:252
spells out why: '/* Trigger creation of session keyring. */'.
mldsa_signed_load() is the only run_setup() user in the file that omits
it.

Why it matters: the setup script adds the key with 'keyctl padd
asymmetric ebpf_testing_key @s', i.e. add_key(2), which calls
lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE). The
KEY_SPEC_SESSION_KEYRING case with KEY_LOOKUP_CREATE runs
join_session_keyring(NULL) whenever cred->session_keyring is NULL (or is
the UID keyring). That creates a brand-new session keyring inside the
forked script process only; it dies with the script.

The parent test process then loads with attr.keyring_id =
KEY_SPEC_SESSION_KEYRING, which resolves with
bpf_lookup_user_key(attr->keyring_id, 0) - no KEY_LOOKUP_CREATE - so it
gets the user-session keyring instead, which never received
ebpf_testing_key. The load then fails and ASSERT_OK_FD(prog_fd, "ML-DSA
signed loader load") reports a failure.

In a full run this is hidden: loadtime_no_map() is the first subtest and
loadtime_verify() installs the session keyring for the whole process,
which is why the log in the commit message shows #424/15
mldsa_signed_load:OK.

Running the subtest on its own, e.g.

    ./test_progs -a 'signed_loader/mldsa_signed_load'

skips every subtest that would have created the keyring, and the new
subtest fails.

> diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
> index 202e6e6418fe2..2737c1a2bcfd6 100755
> --- a/tools/testing/selftests/bpf/verify_sig_setup.sh
> +++ b/tools/testing/selftests/bpf/verify_sig_setup.sh

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32530917987
--===============8728225314386077632==--
