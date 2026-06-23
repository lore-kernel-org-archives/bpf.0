Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A5394470
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256971; cv=none; b=iDlMMN9UbEcfppFRGbMUFoCKLEpaTEWzdkcPrp+4+/+J3RmNIQZq7A1Og33rTlHNIGAQlrU8LZrBoDluyq/C14qb1SD3NiXaW0vh2HhnXrxPjblwh31jx/oYSAg2J4bqUM682BSCCcO2vKdImhFIbr8fIx/vkyllMK2s4oaJGpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256971; c=relaxed/simple;
	bh=JRiZLmrh7FDS1s7CwK3aEmumdifedif+bcgOT2MGL8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FQ8jtSxpcbao8uc4EPiyY1WfPKL56krCNv95K1u4iEQxAbdO8qzcmgDQ/RlgKWrMQL8B945a34sreqVZOmqUoCkiw3LpNfbBbMBhjBivVGF8Udt9FCgjNrSF1lD7o6yDPsPb04urp9y7+j0Dja2Xd/RQObfEa7XnfTy3u7VoWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knGmDnSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knGmDnSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1551F000E9;
	Tue, 23 Jun 2026 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782256970;
	bh=s0Kj1UIYcQ/mLdXiRqjv+B6Xo9wXX/8PsHwBVn+ezco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knGmDnSi7rxB9ZUSpeGAUsE5OaDDLrENjDhIo1Fs43n3CqlUYSQk51agx59Ed6Jey
	 tDCronaFd7h4Zd4YIA6MTijiM6OnFVeuSNOlE7NfrTXm5GErDBTf/tG8QUKlBjBk0/
	 k++wyHMthKfk/CivjUTkm348SulPQ34+XL8fafYXLJbZ1FiVzrdzJUUPP1efL3OTyH
	 iqGOoQ02DFDw9miVTL+aq7hAXwx4jEwXQpDgaCcjRL7/HOuEAeahRqMXrT34cC/xl4
	 E7Y3ka9o1VynywLqxdCYVNpMftWcBNqkDRH5yHR2beAGbk56e3qj+NJNV6Y3/GxIc7
	 DhSGKgnCHSFXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 11/15] bpf: tcp: Support selected sock_ops
 callbacks as struct_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623175006.3136053-12-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
 <20260623175006.3136053-12-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 23:22:49 +0000
Message-Id: <20260623232250.6F1551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf_tcp_ops allows sleepable BPF programs which will trigger kerne=
l panics when executed within the RCU read-side critical sections of the di=
spatcher macros.
- [Low] Multi-line comments in BPF subsystem files must have the opening `/=
*` on its own line.
--

commit c794084a252357df7f0bbf934f1e1707d2dd52fd
Author: Martin KaFai Lau <martin.lau@kernel.org>
Subject: bpf: tcp: Add bpf_tcp_ops and support attaching to cgroups

This commit adds a TCP-specific struct_ops type, bpf_tcp_ops, and supports
attaching it to cgroups. It wires up several existing sock_ops callbacks to
allow each callback to have its own function signature.

Link: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/vie=
w?usp=3Dsharing

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6d376ea4d1c0..2102f9f2afd6 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
[ ... ]
> @@ -2953,12 +2953,120 @@ static inline void tcp_clear_sock_ops_cb_flags(s=
truct sock *sk)
> =20
>  #endif
> =20
> +#if defined(CONFIG_BPF_JIT) && defined(CONFIG_CGROUP_BPF)
> +
> +struct bpf_tcp_ops {
> +	/* Should return the initial SYN (active open) or SYN-ACK (passive open)
> +	 * retransmission timeout. Return the timeout in jiffies, or <=3D 0 for
> +	 * the kernel default.
> +	 *
> +	 * @req: request_sock on the passive (synack) path; NULL otherwise.
> +	 */

[Severity: Low]
This isn't a bug, but could these multi-line comments be updated to place t=
he
opening /* on its own line?

[ ... ]
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> new file mode 100644
> index 000000000000..cf53c95a0dbc
> --- /dev/null
> +++ b/net/ipv4/bpf_tcp_ops.c
[ ... ]
> +BPF_CALL_0(bpf_tcp_ops_get_retval)
> +{
> +	struct bpf_tramp_run_ctx *ctx =3D
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	/* bpf_get_retval() is only exposed to timeout_init/rwnd_init, which
> +	 * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the int
> +	 * return value chained across the bpf_tcp_ops attached to the cgroup
> +	 * and is this program's saved_run_ctx.
> +	 */

[Severity: Low]
This isn't a bug, but would it be better to adjust this multi-line comment =
so
that the opening /* rests on its own line?

[ ... ]
> +static struct bpf_struct_ops bpf_tcp_ops =3D {
> +	.verifier_ops =3D &bpf_tcp_ops_verifier,
> +	.init_member =3D bpf_tcp_ops_init_member,
> +	.init =3D bpf_tcp_ops_init,
> +	.validate =3D bpf_tcp_ops_validate,
> +	.name =3D "bpf_tcp_ops",
> +	.cgroup_atype =3D CGROUP_TCP_SOCK_OPS,
> +	.cfi_stubs =3D &__bpf_tcp_ops,
> +	.owner =3D THIS_MODULE,
> +};

[Severity: High]
Is it possible for sleepable BPF programs to be loaded for this struct_ops
type?

Without a .check_member callback to explicitly reject them, the verifier
might allow sleepable programs to attach.

If a sleepable program is attached, could it trigger a scheduling while
atomic kernel panic?

Looking at include/net/tcp.h, the callbacks are invoked inside an RCU
read-side critical section:

bpf_tcp_ops_call()
    rcu_read_lock_dont_migrate();
    bpf_cgroup_struct_ops_foreach(...) {
        if (tcp_ops->op)
            tcp_ops->op(...);
    }
    rcu_read_unlock_migrate();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.3136=
053-1-ameryhung@gmail.com?part=3D11
