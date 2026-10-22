Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700750;
	b=qlMbvxLurgN/EyOGnpI0nWqrHYTqloV53sdXM17atBJA780TUetwdrSh4jV00BL/8Mwa
	 B/HmYP2yrYGgtUYUs3ttBI1r9Dw/G1OhMnoHob64cWa9R8iXvWnrOWpdCD62CwtDfJS2u
	 g0/7BTuZWVQUY9RLZp6sMgPnWjXKTPqQAK9j3MfV7qrJuDG4kFKkO/70wIVNv1z3yiCqb
	 3Er9CwvjNmPKD++SyEiIg+3NBkprpz/oL+h4+EXLWcZXD08skCHTK2NsVElbhUCjgBQrW
	 mjTnkewNNSeRoB0V4RJficO9s2FQoh//+2zH7zKWWjcfbvAM1GsPhtfm+9ZUVuvaPrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700750;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ux1UTnRjOyGqJzOYM5Hv6XVTNeyYxnuotg3pXhf5HHs=;
	b=IkGWQrenxz9YaKisx5AOISX8OYTFS4dzlQuAewGGj6LhovLppxzTuptCeSCtdzCPJ2J0
	 52neKcY2WTDu85NgMNakA7YkRxblITC8BEln323gcIefO+r3MH5tNv4a7mJtIACNupz1C
	 kCbmM4swCT2JDDSCczt1fkc33UofDH5l0Uu4ZMrt5Cs/Yv1kxR7FrEOO0agOqb6fXplEH
	 n0uRXR9IXZXnwOXzuuUyCm/DM8rLE6MC6BoFBcYIWXmsTp4IfPvQBSCbyGG95YaNyePzH
	 KvZPCKbAmubXZW1B2Oawjq7wg9L1Isdww9si2qNPtAWyf/gS+u0sr2N8OLRrHgRGaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLMS0l8S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5986606A323
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLMS0l8S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8679F1F031E1
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700749;
	bh=ux1UTnRjOyGqJzOYM5Hv6XVTNeyYxnuotg3pXhf5HHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RLMS0l8SrlVSlB+xSKm6w6FYJ1BVIP2OUvpbyz9MikbM20bH8i83IdqYLHnzS4qj9
	 vo6B8FxfAsRueY9WSJTqmuWYCQSQkIN60PxS1EOjtlPkF8g30tel+vLlAPnohHXmRv
	 /Vbi1+UaOcDgUZ0i0fi6x/na8nusRwiADaFX9FXU32HXstuRnUFimv6wlTGqn34WfD
	 QMfTzkYILeeei8YsWI50/UKTnIXVBnU/aSI39gffsIi6/ScqbVu8/ubBXYIWQU9gCd
	 GSwDnvTkIbRy4NYjw2TbXlJoApzGgMFRPZgGDgCAPArwrn6dScfyWS8TCD77ysDeE5
	 19uIGvmDPyrRA==
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so221905c88.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 13:25:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxA8gXXR5eQKZX+7TF89F+/bOAsEQ1Y0JMdFTUxw95L78LmvK7sjNYxL0fbkM55add5Z3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEs8T1nCDKSMiNMGecdzsLYqO/2qpFQsINWuSOag5wHf34+C/k
	mHcEC0RgBb4BfWZjRTNo0iv6BNPyDLmSXzZPbOQ1mbwK1VvJib69zKtf9wi02XUQa4HHCIdrYYl
	aczjCaups/hgZaQQZ5pp0ckw6y0+wUPE=
X-Received: by 2002:a05:7022:1707:b0:166:9e0d:3b56 with SMTP id
 a92af1059eb24-1959a382fb4mr475195c88.38.1792700748990; Thu, 22 Oct 2026
 13:25:48 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <DM4PR12MB61369D00ED2FCFEDAE0E4597DE652@DM4PR12MB6136.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB61369D00ED2FCFEDAE0E4597DE652@DM4PR12MB6136.namprd12.prod.outlook.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 22 Oct 2026 13:25:36 -0700
X-Gmail-Original-Message-ID: <CAKtyLkF3mVu8AXWybMGr3+=0F4OMndcV=M-2m-PGz5afE4H1cw@mail.gmail.com>
X-Gm-Features: AclHuK-w0c1onI8im_hxrE8Vj8Tb7-7Hy-SNC8hLk4Qv6iomWwee3Oh6ZTdAJrg
Message-ID: <CAKtyLkF3mVu8AXWybMGr3+=0F4OMndcV=M-2m-PGz5afE4H1cw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: Manuel Huber <manuelh@nvidia.com>
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 11:02=E2=80=AFAM Manuel Huber <manuelh@nvidia.com> =
wrote:
>
> On Mon, Oct 19, 2026 at 04:15:57PM -0700, Fan Wu wrote:
> > You might need to explain why the existing keyrings, i.e.
> > builtin/secondary/platform cannot be used in your scenario. Like the
> > firmware is not trusted?
>
> As touched upon in [1], the scenario uses an ephemeral VM whose
> IEP policy would be assembled after boot. There is a mix of explicitly
> trusted dm-verity root hashes and possibly signed dm-verity layers
> which can vary per VM, so the final IPE policy would not necessarily
> be known ahead of time.
>
> This specific scenario is Kata Containers on Kubernetes. Each
> Kubernetes pod runs in a headless Kata VM with a static dm-verity
> protected rootfs, while its container image layers are delivered
> dynamically as dm-verity protected block devices. The kata-agent acts
> as trusted bootstrap userspace and would author the IPE policy for that
> particular guest before starting its workload containers.
>
> The firmware is trusted in this scenario. A public policy-signing
> certificate could be compiled into the builtin keyring or provisioned
> through the platform or secondary keyrings. Because the policy would be
> authored inside the guest, however, the corresponding private key would
> also have to be shipped as a static artifact in the guest rootfs and
> shared by every guest using that build.
>
> Instead, the kata-agent would generate an ephemeral, per-guest
> policy-signing key pair, provision its public certificate, sign the
> policy, destroy the private key, and restrict the keyring before
> allowing untrusted code to execute.
>
> A dedicated .ipe keyring thus provides a purpose-specific runtime
> provisioning path for this scenario. Once the certificate has been
> added, the keyring can be restricted against further enrollment.
>
> I envision other scenarios with similar characteristics may benefit from
> a dedicated .ipe keyring as well.
>
> I could elaborate more on this, e.g., on the how users' deployed
> container images translate to dm-verity protected image layers etc.
> (the erofs snapshotter is used and there is no filesystem sharing
> between host and guest, image layer transport is realized via block
> device attachment), but I am trying to keep this response brief. Some
> more breadcrumbs on the combination of containerd, IPE, Kata can be
> found in [2] and [3].
>
> [1] https://lore.kernel.org/r/SJ1PR12MB61246B0BF58BC2B6F0A79D30DE9F2@SJ1P=
R12MB6124.namprd12.prod.outlook.com
> [2] https://github.com/containerd/containerd/issues/12081
> [3] https://github.com/kata-containers/kata-containers/issues/10943

Thanks for the explanation. This clarifies a lot. Please include this
context in the commit message and doc for v2.

Also, one thing I missed earlier: before the policy verification call,
please also check:

ipe_keyring->restrict_link->check =3D=3D restrict_link_reject

so we make sure the restriction function is the right one.

Fan
