Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456D13D51E;
	Sat, 17 Oct 2026 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248512; cv=none; b=kWIJow3ZrnCBQmIBCvvaqInIrpq39E7VYt5OJfyXpRymfBaIflw0ZiI4Lox2yfLJF0/ZUa7EtXhQ8HUPZ19j0p4BvBkVFK98am49vvmMONvy33gaHSA817bBJefbvpZfrKZNE+kArKO6UWt9NSkX/dIn7yk1n8RngXrvmfeXcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248512; c=relaxed/simple;
	bh=u24gZ/Io1Ln7vXZIQXcUxi7RPudTWJW3uVTFWn9E9eY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qGTVKDVqA0IKpGVyXAB8cUTq2/QEq3aew05YjXb1KxaOHr/csjTCvQq1/uOfytu9SYml3CyJjHHJjowfrvYVZe3LLECn1qiGBpO3DmtZvsc4K+qAF3m2bB7t/WbCwvURvhS6RFEDgR9zVcxGV31DaA7xK06TTF9KTIYD6PtTX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRCkkH9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRCkkH9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796861F000C4;
	Sat, 17 Oct 2026 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792248511;
	bh=+p0B3jUlQAb9H5sRzSd0ymPI8w6cU+ZoONv5g1jqicc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRCkkH9mf4+x1Lgq9wKaGxqREqI0Fg7N9ckD0m8Ik99R15uDfh5HAUHVSg0lEbBNa
	 4PWOXR23XKjbPc821Mvk5NH8vXUOr7k3OEJJxF3VU4k/A3y7Ly6OUYovDyxEZTcsUL
	 Sk0IzW6fD8PTivq6BtZqIxZ3xJjr6DXPTPKiTjBhkAs29K1tn4ul/VPewzucksuINC
	 4b1VxC4FlJnAxW0HjxVP4z0ZBoc5zXMy9Cjn6uJGXaG2MVeSNxptpvYvKjF1fOS4N5
	 rZTEs0XPPIlE2Bx/Kjqead6DnpC1h0BduTfsE4j36Y4tUo9PgubELOo0P+jA5EjMrs
	 AMhSZrO/EHYpw==
Message-ID: <sashiko-outbox-175566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add syscall common attrs support for
 xdp link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261017142649.51047-3-leon.hwang@linux.dev>
References: <20261017142649.51047-1-leon.hwang@linux.dev>
 <20261017142649.51047-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:48:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] bpf: NULL deref and format string bug in bpf_xdp_link_attach()=
 via bpf_log()
- [Critical] bpf: prog refcount underflow in link_create() if bpf_log_attr_=
finalize() fails
- [Low] bpf: link failure in bpf_xdp_link_attach() when !CONFIG_BPF_SYSCALL
--

commit fa16fd00d8499a718392032e57d440248e048afc
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attrs support for xdp link_create

This commit passes the verifier log to bpf_xdp_link_attach() so that XDP
link creation can report target_ifindex and driver errors through BPF
syscall common attributes.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 252b479937a4d..e96d5f09486f5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5921,7 +5921,7 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr, struct bpf_common_a
>  		break;
>  #ifdef CONFIG_NET
>  	case BPF_PROG_TYPE_XDP:
> -		ret =3D bpf_xdp_link_attach(attr, prog);
> +		ret =3D bpf_xdp_link_attach(attr, prog, log);
>  		break;
>  	case BPF_PROG_TYPE_SCHED_CLS:
>  		if (attr->link_create.attach_type =3D=3D BPF_TCX_INGRESS ||

[Severity: Critical]
Can the cleanup path in link_create() underflow prog's reference count if
bpf_log_attr_finalize() fails after bpf_xdp_link_attach() succeeds?

When bpf_xdp_link_attach() succeeds, bpf_link_init() transfers ownership of
prog's reference to link->link.prog and bpf_link_settle() installs the link
file descriptor, returning a non-negative fd in ret.

At the out label in link_create(), bpf_log_attr_finalize() writes
log_true_size to uattr_common even when nothing was logged:

kernel/bpf/log.c:bpf_log_attr_finalize() {
	...
	if (attr->offsetof_true_size &&
	    copy_to_bpfptr_offset(attr->uattr, attr->offsetof_true_size, &log_true=
_size,
				  sizeof(log_true_size)))
		return -EFAULT;
}

If uattr_common points to read-only memory, copy_from_bpfptr() in
__sys_bpf() succeeds, bpf_xdp_link_attach() attaches and settles the link,
and then bpf_log_attr_finalize() returns -EFAULT:

kernel/bpf/syscall.c:link_create() {
out:
	/* preserve original error even if log finalization is successful */
	err =3D bpf_log_attr_finalize(&attr_log, log);
	if (err)
		ret =3D err;

	kfree(log);

	if (ret < 0 && prog)
		bpf_prog_put(prog);
	return ret;
}

Overwriting ret with err causes link_create() to call bpf_prog_put(prog) on
a reference that is now owned by the settled bpf_link, leading to a
use-after-free of struct bpf_prog while the link remains attached in the
process fd table.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 18dc88990510a..fdc1de21f3589 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[ ... ]
> @@ -10771,7 +10772,8 @@ static const struct bpf_link_ops bpf_xdp_link_lop=
s =3D {
>  	.update_prog =3D bpf_xdp_link_update,
>  };
> =20
> -int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pro=
g)
> +int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pro=
g,
> +			struct bpf_verifier_log *log)
>  {
>  	struct net *net =3D current->nsproxy->net_ns;
>  	struct bpf_link_primer link_primer;
> @@ -10784,6 +10786,7 @@ int bpf_xdp_link_attach(const union bpf_attr *att=
r, struct bpf_prog *prog)
>  	dev =3D dev_get_by_index(net, attr->link_create.target_ifindex);
>  	if (!dev) {
>  		rtnl_unlock();
> +		bpf_log(log, "Invalid target_ifindex.\n");
>  		return -EINVAL;
>  	}

[Severity: Low]
Will calling bpf_log() in bpf_xdp_link_attach() break linking when
CONFIG_NET=3Dy and CONFIG_BPF_SYSCALL=3Dn?

net/core/dev.c is compiled whenever CONFIG_NET=3Dy, and bpf_xdp_link_attach=
()
is not guarded by CONFIG_BPF_SYSCALL. While helpers like bpf_link_init() and
bpf_link_prime() have static inline stubs in include/linux/bpf.h when
!CONFIG_BPF_SYSCALL, bpf_log() is only compiled via kernel/bpf/log.o when
CONFIG_BPF_SYSCALL=3Dy and has no stub in include/linux/bpf_verifier.h.

> =20
> @@ -10812,6 +10815,7 @@ int bpf_xdp_link_attach(const union bpf_attr *att=
r, struct bpf_prog *prog)
>  	if (err) {
>  		link->dev =3D NULL;
>  		bpf_link_cleanup(&link_primer);
> +		bpf_log(log, extack._msg);
>  		trace_bpf_xdp_link_attach_failed(extack._msg);
>  		goto out_put_dev;
>  	}

[Severity: Critical]
What happens here when dev_xdp_attach_link() fails without setting an extack
message, or when extack._msg contains format specifiers?

In bpf_xdp_link_attach(), extack is zero-initialized on the stack, so
extack._msg starts as NULL. Many failure paths under dev_xdp_attach_link() =
->
dev_xdp_attach() -> dev_xdp_install() return an error without calling
NL_SET_ERR_MSG(), such as netif_xdp_propagate() when a device has no ndo_bpf
callback, or driver ndo_bpf callbacks like netkit_xdp() and veth_xdp()
returning -EOPNOTSUPP or -EINVAL.

When a user provides a log buffer via syscall common attributes and
extack._msg is NULL, bpf_log() passes fmt =3D NULL into
bpf_verifier_vlog() -> vscnprintf() -> vsnprintf(), which dereferences fmt
unconditionally and crashes the kernel.

Additionally, because bpf_log() is a printf-style function, passing
extack._msg directly as the format string rather than using a "%s\n" format
specifier allows any '%' characters in a formatted extack message (for
example from NL_SET_ERR_MSG_FMT() containing an interface name) to be
interpreted as format specifiers by vscnprintf(), and omits the trailing
newline. Should this be guarded with if (extack._msg) and logged with
bpf_log(log, "%s\n", extack._msg)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017142649.5104=
7-1-leon.hwang@linux.dev?part=3D2
