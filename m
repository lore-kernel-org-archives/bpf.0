Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C941B8C4
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352634; cv=none; b=VGtAHfu6VjfNPLeolOaioFTJgTrRExzv5Vu5j0RjPsjTj+wgsNaAaQu8It03OmJTV+jMtTBSR+r9ihqB/nYSB5VY5NCW8oRMx2Hz/JmyfFZvC/ecWGEx0ee8nFkAov2QVB4Eaeve66lRdKbu4zES46st+dlPSSp1B6uqzx1vBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352634; c=relaxed/simple;
	bh=xE/607n33wc8SBTP48L8IL0+/WCAz4+q9ZdXutGxo8Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mDZ7adUL1ggtQlUxln7bXizYxiJp4TTmLtc9KHSG/rJcDLUyVe0G96EOVvMGn9de/bRzgHRDMGSsfzbCYhvzQpZTctT2IGGPdZN2z/2rBS0rpapF8nlbiu9y/0QyPQDBAQ3R7AJpB0dlGJOIhcWzVLgxBVnjFikdElM4YDUGB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCpSaJyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCpSaJyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6FA1F00ACA;
	Fri, 21 Aug 2026 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787352631;
	bh=5yGc9TmN1MnS0yA4R7F++B5iZ1EaRh/3Y3lh6csrAOM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PCpSaJyyKKE1WP7xzPXqPz4S2Vezcd/C/M/2uB2T/2ElBEpTWW2XFdedYwvOdcDSC
	 /euBh69floOD64NdtKkRECwpzej1304Edh4rIqEWywkeTE0y1Zb3S7gYtGmBggSSsJ
	 7m+C/Rt8MmkKKlzb2dASY9RCr3C99pfV28JaNhCl+917TMC1SgiTK0aeR0oMtF/FAq
	 nDlluBcUhp8zHznJgQXEP3c8FOSsattl3ThriPx8dxhvnorwVbXW6FRmHD7MfaxBrY
	 TAZhLhu0lx+oIO0xZ/J7+1FJTEl+rTwcWmAW7Aeu/hmG0Yju3nhjPLRbyU2MeHvAT2
	 +8MilJj5HKjlg==
Content-Type: multipart/mixed; boundary="===============2259810960346566057=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <134ca20a69559d82f0759a469bf511466e0a8aa2716a29d541b407a59661261f@mail.kernel.org>
In-Reply-To: <20260821214111.1120748-12-daniel@iogearbox.net>
References: <20260821214111.1120748-12-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 11/11] Documentation/bpf: Document the bpf keyring and improve examples
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 22:50:31 +0000 (UTC)

--===============2259810960346566057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/signing.rst b/Documentation/bpf/signing.rst
> index e73eaaebd8b15..e359977462673 100644
> --- a/Documentation/bpf/signing.rst
> +++ b/Documentation/bpf/signing.rst

[ ... ]

> @@ -291,11 +295,19 @@ auditable. (Illustrative - error checking elided.)
>              if (kernel)
>                      return 0;                       /* trust in-kernel loads */
>
> -            if (verdict != BPF_SIG_VERIFIED)
> +            if (verdict != BPF_SIG_VERIFIED) {
>                      ret = -EPERM;                   /* must be validly signed */
> -            else if (ktype == BPF_SIG_KEYRING_USER &&
> -                     !bpf_map_lookup_elem(&trusted_user_keys, &serial))
> -                    ret = -EPERM;                   /* key/keyring not allowlisted */
> +            } else switch (ktype) {
> +            case BPF_SIG_KEYRING_BUILTIN:
> +            case BPF_SIG_KEYRING_BPF:
> +                    break;
> +            case BPF_SIG_KEYRING_USER:
> +                    if (!bpf_map_lookup_elem(&staging_keys, &serial))
> +                            ret = -EPERM;
> +                    break;
> +            default:
> +                    ret = -EPERM;                   /* keyring not in policy */
> +            }

The illustrative BPF program uses BPF_SIG_KEYRING_BUILTIN,
BPF_SIG_KEYRING_BPF, BPF_SIG_KEYRING_USER and (earlier) BPF_SIG_VERIFIED
as compile-time constants, which requires enum bpf_sig_keyring / enum
bpf_sig_verdict to be present in vmlinux BTF (i.e., in the generated
vmlinux.h). A subsystem pattern flags this as potentially concerning:

Nothing in the kernel references those enum types by name: the aux fields
are plain integers (struct { s32 keyring_serial; u8 keyring_type; u8
verdict; } sig; in include/linux/bpf.h), the only user of the enum type is
the file-static bpf_classify_keyring() in kernel/bpf/verifier.c, and
there is no BTF_TYPE_EMIT() for them - contrast BTF_TYPE_EMIT(enum
bpf_features) in bpf_check(), which exists precisely because an
otherwise-unreferenced enum does not reach BTF. If the enum is not
emitted, these case labels do not compile.

Notably the series' own BPF-side test program does not use the
enumerators either: progs/test_signed_loader_lsm.c reads the raw fields
into ints and the comparison happens in userspace against a hand-copied
enum (prog_tests/signed_loader.c). A static function's return type may
still pull the enum into vmlinux BTF depending on the pahole encoder, so
perhaps this works in practice - but it might be worth checking whether
the example compiles on a system where those enums do not appear in
vmlinux.h.

>
> +Such a policy is what makes a caller-supplied keyring usable at all before
> +``bpf.keyring_unsealed=1`` is set: the allowlist bounds which staged keys
> +count, and the LSM itself has to protect them from being tampered with.

Can the phrasing "before bpf.keyring_unsealed=1 is set" be read as
describing a temporal transition? bpf.keyring_unsealed is a boot
parameter backed by __ro_after_init storage exposed 0444 (kernel/bpf/
keys.c), and bpf_keyring_enforced() reads it directly, so within a boot
it is either always 1 or always 0 - there is no "before it is set". The
same commit adds, roughly 190 lines later, "there is no window early in
boot during which a caller-supplied keyring is still accepted", which
could be read as contradicting the phrasing here. The intended meaning is
presumably "on a system that does not boot with bpf.keyring_unsealed=1"
(the phrasing used correctly in the 'Caller-supplied keyrings are for
staging' section: "A system that has committed to the bpf keyring refuses
this path outright").

[ ... ]

> @@ -390,33 +407,152 @@ Keyrings
> +The bpf keyring
> +---------------
> +
> +A system keyring needs a kernel rebuild or a vouched-for enrollment to rotate a
> +key, and grants BPF-signing trust to keys trusted for everything else in the
> +kernel too. A caller-supplied keyring, at the other extreme, is filled by the
> +very process that loads the program and so carries no trust of its own.
> +
> +The bpf keyring fills that gap and is the trust anchor which a signed BPF
> +deployment should be built on top of: a keyring named ``.bpf``, selected with
> +``VERIFY_USE_BPF_KEYRING``, that an operator provisions at boot with a key
> +scoped to BPF program loading and nothing else in the kernel's trust hierarchy.
> +It is owned by the operator rather than by the loader, and rotatable across a
> +reboot without touching the kernel image. It is modelled after the dm-verity
> +keyring (see ``dm_verity.keyring_unsealed=``) and provisioned the same way: an
> +initrd runs the ``keyctl`` steps below before handing off to the rootfs.
> +
> +Provisioning
> +~~~~~~~~~~~~
> +
> +The keyring is created during ``late_initcall`` and is **sealed empty** by
> +default: it carries a reject-all restriction, so no key can ever be added and
> +``VERIFY_USE_BPF_KEYRING`` fails with ``-ENOKEY`` for the whole boot.
> +
> +``bpf.keyring_unsealed=1`` leaves it unrestricted at init so the initrd can
> +provision it. The keyring is not linked into any process keyring, so it is
> +addressed by the serial ``/proc/keys`` reports. Steps would be as follows::
> +
> +    serial=$(awk '$8 == "keyring" && $9 == ".bpf:" { print strtonum("0x" $1) }' \
> +             /proc/keys)

Does strtonum() work in the initrd environment this snippet targets?
strtonum() is a GNU awk extension. The surrounding text explicitly places
these commands in an initrd ("an initrd runs the keyctl steps below
before handing off to the rootfs", "as a third step in the initrd"),
where the awk implementation is typically busybox awk or mawk, neither of
which provides strtonum(); the snippet would fail there with an
unknown-function error and leave serial empty, after which keyctl padd ...
"" silently targets nothing useful. The field selection itself is correct
(security/keys/proc.c prints serial, flags, usage, timeout, perm, uid,
gid, type as fields 1-8, and keyring_describe() emits ".bpf: <n>" /
".bpf: empty", so $8/$9 match - the same layout the selftest parses in
prog_tests/signed_loader.c). Only the hex conversion is non-portable; the
raw $1 is already a form keyctl accepts.

[ ... ]

> +Provisioning has to complete before control passes to the rootfs. The keyring
> +is unrestricted for as long as it is unsealed, so the first writer wins: an
> +initrd that hands off before restricting leaves that window open to whatever
> +runs next.

Does "the first writer wins" state the opposite of the implemented
semantics? Until keyctl restrict_keyring runs, bpf_keyring->restrict_link
is NULL (kernel/bpf/keys.c only restricts when !bpf_keyring_unsealed), so
the keyring accepts an unbounded number of further keyctl padd links, and
every key added before the restriction becomes part of the trust anchor.
It is the first party to *restrict* the keyring - not the first party to
write to it - that closes the window; the series' own selftest relies on
exactly that ordering (prog_tests/signed_loader.c enrolls, asserts
-ENOKEY while unrestricted, then calls KEYCTL_RESTRICT_KEYRING). An
operator reading "the first writer wins" could conclude that enrolling
their key early is itself protective and that the keyctl restrict_keyring
step is only about activation, when it is the only thing that bounds the
enrolled set.

> +
> +Enforcement
> +~~~~~~~~~~~
> +
> +``bpf.keyring_unsealed=1`` states that the bpf keyring is *the* trust anchor for
> +this boot, so it does more than unseal. From the first program load onwards a
> +caller-supplied user/session keyring is refused with ``-EPERM`` and a verifier
> +log message, whether or not provisioning ever completed. The system keyrings
> +stay selectable.
> +
> +Enforcement is readable at ``/sys/module/bpf/parameters/keyring_unsealed``. It
> +is therefore immutable from userspace, and there is no window early in boot
> +during which a caller-supplied keyring is still accepted.

Does "readable at <sysfs path>. It is therefore immutable from userspace"
establish the right causal link? Being readable in sysfs implies nothing
about mutability. The two independent reasons the value cannot change are
(a) static bool bpf_keyring_unsealed __ro_after_init; with
module_param_named(keyring_unsealed, ..., 0444) (kernel/bpf/keys.c), i.e.
the attribute is mode 0444 and the variable is write-protected after
init, and (b) bpf_keyring_enforced() returns the boot flag rather than
the keyring's runtime state - which is precisely how the implementing
commit 393136a14e636 phrases it ("Deriving this from the boot flag rather
than from the keyring's runtime state keeps the decision immutable from
userspace"). As written the sentence attributes immutability to the wrong
property, and a reader could infer that a writable sysfs attribute would
be the mechanism for toggling enforcement.

[ ... ]

> @@ -436,16 +572,47 @@ Two fields are recorded in ``prog->aux->sig`` for an LSM to inspect:
>
> -Producing a signed object
> -==========================
> +Producing and loading a signed object
> +=====================================
> +
> +Generating a signing key
> +------------------------
> +
> +Signing is algorithm agnostic: the algorithm comes from the X.509 certificate
> +and the PKCS#7 ``SignerInfo``. Anything the X.509 and PKCS#7 parsers understand
> +works with no BPF-side change. RSA::
> +
> +    openssl req -new -nodes -utf8 -sha256 -days 36500 -batch -x509 \
> +            -config x509.genkey -outform PEM \
> +            -out signing_key.pem -keyout signing_key.pem
> +    openssl x509 -in signing_key.pem -outform der -out signing_key.der
> +
> +ML-DSA-87 (FIPS-204), which needs openssl 3.5 or later and ``CONFIG_CRYPTO_MLDSA``
> +in the kernel. Note the absence of a digest option: ML-DSA hashes the message
> +itself and openssl rejects an explicit digest for it::
> +
> +    openssl req -new -nodes -utf8 -days 36500 -batch -x509 \
> +            -newkey ML-DSA-87 -config x509.genkey -outform PEM \
> +            -out signing_key.pem -keyout signing_key.pem
> +    openssl x509 -in signing_key.pem -outform der -out signing_key.der

Both new key-generation examples (RSA and ML-DSA-87) pass '-config
x509.genkey', but signing.rst never says what x509.genkey is, never shows
its contents, and never points at a place that does. A reader copying
either command verbatim gets 'Can't open x509.genkey for reading' from
openssl. The only in-tree definitions are certs/x509.genkey and
Documentation/admin-guide/module-signing.rst (which spells out the [req]/
[req_distinguished_name]/[myexts] content); the selftest the examples
were lifted from (tools/testing/selftests/bpf/verify_sig_setup.sh,
x509_genkey_content) writes the file itself before invoking openssl. A
one-line pointer to certs/x509.genkey or Documentation/admin-guide/
module-signing.rst would make the examples runnable.

> +
> +``bpftool`` handles the following internally: openssl 3.5 and earlier cannot
> +combine ML-DSA with ``CMS_NOATTR``, so it falls back to signedAttrs, where
> +only SHA-512 is permitted. This mirrors what module signing does as well.

Does the version boundary match what bpftool actually does?
tools/bpf/bpftool/sign.c guards the fallback with '#if
OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER <
0x40000000L', i.e. it drops CMS_NOATTR and switches cms_digest to
EVP_sha512() on every OpenSSL 3.x, not only on 3.5 and earlier.
crypto/asymmetric_keys/Kconfig states the constraint as 'OpenSSL < 4.0
(and thus any released version)'. As written the doc implies a user on
OpenSSL 3.6+ gets the CMS_NOATTR path, which they do not. (The
imprecision is inherited from the in-code comment in sign.c/
scripts/sign-file.c, so a fix probably wants to touch both;
behaviourally this is invisible to users since bpftool handles it, hence
not urgent.)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32530917987
--===============2259810960346566057==--
