Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120830DEB2
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205420; cv=none; b=VJtHvurRcx454ZQKiv+T2sSoU33w8QiJ09Wi7An6URgmWvDgCMoOYD77M20HieHR1sLyy1gRKWXTRVePKTPH+lRgqkZ5pI9H044A4yc3UTY1dOzi5S/Wz9Zw06ESoMJKSOFp8CHFr03FTr1cVXnWZpz4yGLBSLoJniorUQ+4CSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205420; c=relaxed/simple;
	bh=OiugJMly+i7unRmaL6V8nuDdep5O40xGltAwV9UFKGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FvWNAkMoNCbBzZtayK3Sxis8TFA5CcHNLDcYl4+gbUM29jg64p5Ztn2U/7QNwrEmmeCMemeeevx0lCCnAK5ELZSkm02kAtowiNJfdOZ/7zBEniqTGJPdSS+D3ZGxHJxyK3zTIYgKJWBvkptu2pcoNvTeEgWxATB5ocEnBlI/urM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP1+kTkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP1+kTkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05C81F000E9;
	Thu, 11 Jun 2026 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781205419;
	bh=E6CjeI7zXjkOdnUZrRrcCaz99iYzzvwM0jZ70W8h71g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DP1+kTkd99MT0o3XZ76foUBNiFXC/t7X31XaVFXZiqZ3VjTWTfW/wKr8jLPH9Q2sW
	 TQJQTBa1TnbuCXFWji2GOOMypaakFrrZ+TPMro/ZZmE3gj19PssFcVmD6u0b1nFKKa
	 EgjCtpm9ml8rk3eV0yzC5wu2z9jICtmXWtBpUdbBRBQd/B4x8zOCStlwybCeATqG2I
	 4Cx1DzGkr5Qgx96ObFAm6QdqduUlwMm4NwvcMkdEUlC7VdINWgtaQWzkv0Jb8G/rd3
	 AV2DPtMGZksWjpLNKbjrIBfmbBnGhwhb0uMAYQElbM4X2DPnZO8JdXHv7y0oipM1RV
	 legqAD6oqbiXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Add LoadPin support for eBPF program loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Roberts via B4 Relay" <devnull+alex.roberts109.outlook.com@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>
References: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 19:16:58 +0000
Message-Id: <20260611191658.D05C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Unprivileged eBPF program loading can inadvertently hijack the=
 system-wide LoadPin pinned root, causing Denial of Service or Privilege Es=
calation.
- [High] The LoadPin eBPF trust mechanism can be trivially bypassed using s=
tandard system interpreters like the dynamic linker (`ld.so`).
- [High] The LoadPin eBPF trust mechanism can be bypassed by a privileged a=
ttacker using prctl(PR_SET_MM_EXE_FILE).
- [High] The LSM hook fails open (allows loading) when `get_mm_exe_file()` =
returns NULL for a user process.
- [Low] Adding a new kernel_read_file_id without updating SELinux triggers =
`BUILD_BUG_ON_MSG` assertions, breaking the build when SELinux is enabled.
- [Low] Missing explicit inclusion of `<linux/mm.h>` for `get_mm_exe_file`.
- [Low] Minor typos in Kconfig help text and preprocessor comment.
--

commit 0df53c96b1653ee0e3d8bee4fe7395c46c0de62f
Author: Alex Roberts <alex.roberts109@outlook.com>

Add LoadPin support for eBPF program loading

Add LoadPin LSM hook to bpf_prog_load to prevent loading of BPF
programs from untrusted filesystems

> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read=
_file.h
> index d613a7b4dd35a..75cbd514562fb 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -15,6 +15,7 @@
>  	id(POLICY, security-policy)		\
>  	id(X509_CERTIFICATE, x509-certificate)	\
>  	id(MODULE_COMPRESSED, kernel-module-compressed) \
> +	id(EBPF, ebpf) \

[Severity: Low]
Does adding this new ID increase the maximum ID values and trigger build
failures when SELinux is enabled?=20

In security/selinux/hooks.c, there are explicit compile-time checks for the
maximum IDs:

BUILD_BUG_ON_MSG(READING_MAX_ID > 8,
                 "New kernel_read_file_id introduced; update SELinux!");
BUILD_BUG_ON_MSG(LOADING_MAX_ID > 8,
                 "New kernel_load_data_id introduced; update SELinux!");

>  	id(MAX_ID, )

[ ... ]

> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index aef63d3e30dfa..be0754735d5df 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig

[ ... ]

> @@ -42,3 +42,15 @@ config SECURITY_LOADPIN_VERITY
> =20
>  	  This is followed by the verity digests, with one digest per
>  	  line.
> +
> +config SECURITY_LOADPIN_EBPF
> +	bool "Pin ebpf programs to one filesystem"
> +	depends on SECURITY_LOADPIN
> +	help
> +	  eBPF program loading is pinned to the first filesystem from which the
> +	  application loading the progam resides. When enabled, applications on

[Severity: Low]
There is a typo here, progam should be program.

> +	  other filesystems that attempt to load an eBPF program will be reject=
ed.

[ ... ]

> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index f71861f98e1ab..47fd7e247edb3 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -23,6 +23,10 @@
>  #include <uapi/linux/loadpin.h>
>  #include <uapi/linux/lsm.h>
> =20
> +#ifdef CONFIG_SECURITY_LOADPIN_EBPF
> +#include <linux/bpf.h>

[Severity: Low]
Is a linux/mm.h include missing here? The function get_mm_exe_file() is
declared there, and relying on transitive includes might lead to implicit
function declaration errors depending on the architecture and configuration.

> +#endif /* CONFIG_SECURITY_LOADPIN_BPF */

[Severity: Low]
There is a typo in this preprocessor comment, it should be
CONFIG_SECURITY_LOADPIN_EBPF.

> +
>  #define VERITY_DIGEST_FILE_HEADER "# LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS"

[ ... ]

> @@ -204,6 +208,28 @@ static int loadpin_load_data(enum kernel_load_data_i=
d id, bool contents)
>  	return loadpin_check(NULL, (enum kernel_read_file_id) id);
>  }
> =20
> +#ifdef CONFIG_SECURITY_LOADPIN_EBPF
> +static int loadpin_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *=
attr,
> +				  struct bpf_token *token, bool is_kernel)
> +{
> +	int res =3D 0;
> +	struct file *exe_file =3D NULL;
> +	struct mm_struct *mm =3D current->mm;
> +
> +	if (is_kernel || !mm)
> +		return 0;
> +
> +	exe_file =3D get_mm_exe_file(mm);

[Severity: High]
Can this mechanism be bypassed by a privileged attacker using prctl?

An attacker with capabilities to load most BPF programs inherently has
CAP_SYS_RESOURCE. They could open a benign executable on the trusted pinned
filesystem and call prctl(PR_SET_MM, PR_SET_MM_EXE_FILE, fd, 0, 0).

This silently changes their process's exe_file to the trusted file, which
would cause loadpin_check() to evaluate the spoofed exe_file and allow
arbitrary, untrusted eBPF bytecode to load.

[Severity: High]
Does this evaluation miss the fact that interpreters bypass this check enti=
rely?

If an attacker compiles an unauthorized eBPF loader binary and executes it
via the dynamic linker (for example, /lib/ld-linux-x86-64.so.2 /tmp/evil_bp=
f),
the kernel sets the process's exe_file to the interpreter (ld.so).

Because the interpreter resides on the pinned root filesystem, LoadPin will
incorrectly allow the unauthorized program to load eBPF programs.

> +	if (!exe_file)
> +		return 0;

[Severity: High]
Does this LSM hook fail open when get_mm_exe_file() returns NULL?

Returning 0 allows the loading to proceed. Security mechanisms typically
fail closed. The existing loadpin_check() function already contains logic
to handle a NULL file safely by returning -EPERM if enforcement is active.

> +
> +	res =3D loadpin_check(exe_file, READING_EBPF);

[Severity: Critical]
Could this lower-privileged bpf_prog_load path allow an attacker to hijack
the system-wide pinned_root?

LoadPin dynamically sets its system-wide pinned_root to the superblock of
the very first file evaluated by loadpin_check():

security/loadpin/loadpin.c:loadpin_check() {
    ...
    if (!pinned_root) {
        pinned_root =3D load_root;
        first_root_pin =3D true;
    }
    ...
}

If an unprivileged user (or any user with CAP_BPF) executes an eBPF program
from an unpinned filesystem early in the boot process, LoadPin will
permanently pin the system root to that filesystem. This could deny
subsequent legitimate kernel module/firmware loads from the actual root
filesystem, or allow malicious modules to be loaded if placed on the
attacker-controlled filesystem.

> +	fput(exe_file);
> +
> +	return res;
> +}
> +#endif /* CONFIG_SECURITY_LOADPIN_EBPF */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-rfc-loa=
dpin-ebpf-v1-1-11a6c8e6170d@outlook.com?part=3D1
