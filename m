Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5D3B71DA;
	Mon, 31 Aug 2026 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169306; cv=none; b=ZRWWvhHZ75xnMzUc9q+mQHJh8zk3Zt6ev66cf+aYm0e2nJJkt1s+Nrbn0ge00htoqEcmjAkbDkle7qg2fpEXafaOu7a/OHl0E1zNFvNpkZfwQJUy4s/7sljygf+gXxRl322HO6QmlRudBemYYJ8FE69FPU8Q2s/pHHa3GFbE6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169306; c=relaxed/simple;
	bh=G/vWlsR6Zyop8nGpunfiyi7m+av8eWLKR+/lzfrUbz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uuf+JTcx9KoxlxBfakKkxOW+w5GnvmQjzI1uMsCVCk0nkm4qjQ34oEe9TmDkE2cYpL0EDyHfrRWcslJ7AmUbyNqMZMXlB0g1/Ae3gj3dJq2P6MedUUWv2G0meyuck50zk/mknuv2glShy+g60ZSdMuwYT0jAnO35rTvLdS0duSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjsT6X8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjsT6X8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAAD1F000E9;
	Mon, 31 Aug 2026 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169305;
	bh=YBko+KbKsaQweY2012fIHU/9GWR0HwqVYKP8+V8VIlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LjsT6X8q3uJu5tmLEVvEebpgzMYOwDl5w2CsjmvIMK4OoebG2mc8XENt0RFBM6xrm
	 aqXb+GAJfnhzQwrOOc6nZKbiG8gUrEUpfDPCmK2JRyLDXim6grS7WVAOPQ9E1tucUT
	 1UO7NmW0D4K98zeSzj6JeOgjA23bmj+mRI6d1DO2iCKRJu3uBFO1De0Q4RBNZsRURT
	 EZxSfR75wre932CgYaoRh+rXRlAyLcCB885f/l6YifbNXGblXI5Eqm/AtU67jP3h9d
	 +SLFTOV6mCwa31rKM6tVFK0JprGd6wewLt2PUftsINOyIBFGPWsd2oGF/eSZSfQNi7
	 twmsdq5kar6gQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 18/20] verification/rvgen: Add support for BPF
 monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260831090524.106845-19-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-19-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:41:44 +0000
Message-Id: <20260831094144.DEAAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Generated BPF monitor arrays for state and event names lack null=
 termination if names are 32 characters or longer, leading to out-of-bounds=
 reads.
--

commit 53fecfe68f54b9383a7c0b099f9a1311ed5ff3ef
Author: Gabriele Monaco <gmonaco@redhat.com>

verification/rvgen: Add support for BPF monitors

This commit adds the -b flag to the rvgen monitor tool to generate BPF
monitors for deterministic automata. It updates the code generator to emit
BPF-compatible array structures and hooks while maintaining the existing
in-kernel monitor support.

> diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification=
/rvgen/rvgen/dot2c.py
> index 22938ce1bf6cb..5be9fe44a19b2 100644
> --- a/tools/verification/rvgen/rvgen/dot2c.py
> +++ b/tools/verification/rvgen/rvgen/dot2c.py
> @@ -111,10 +111,17 @@ class Dot2c(Automata):
>          min_type =3D self.get_minimun_type()
>          buff =3D []
>          buff.append(f"struct {self.struct_automaton_def} {{")
> -        buff.append(f"\tchar *state_names[state_max{self.enum_suffix}];")
> -        buff.append(f"\tchar *event_names[event_max{self.enum_suffix}];")
> -        if self.is_hybrid_automata():
> -            buff.append(f"\tchar *env_names[env_max{self.enum_suffix}];")
> +        if self.bpf:
> +            # BPF struggles with non-fixed string pointers
> +            buff.append(f"\tchar state_names[state_max{self.enum_suffix}=
][32];")
> +            buff.append(f"\tchar event_names[event_max{self.enum_suffix}=
][32];")
> +            if self.is_hybrid_automata():
> +                buff.append(f"\tchar env_names[env_max{self.enum_suffix}=
][32];")

[Severity: Medium]
Could this lead to out-of-bounds reads in BPF trace output if the monitor
model has state or event names of 32 characters or longer?

When a fixed-size character array is initialized with a string literal equal
to or larger than its size, the null terminator is silently omitted in C.
If the names generated from the model are exactly 32 bytes or longer, these
arrays will lack a null terminator.

Since the BPF verifier permits reading .rodata, string formatting helpers
reading from these fields could run past the array bounds until a null byte
is encountered in adjacent memory. This could cause garbled trace output and
a minor info leak.

Would it make sense to enforce truncation of the source string during
generation, or explicitly ensure null termination here?

> +        else:
> +            buff.append(f"\tchar *state_names[state_max{self.enum_suffix=
}];")
> +            buff.append(f"\tchar *event_names[event_max{self.enum_suffix=
}];")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D18
