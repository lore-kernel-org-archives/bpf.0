Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698856;
	b=WltmZGzavikKfo5VGD6rBWBn0Cdek596/VuF42yVwb5A1n9k+LWqDzcFpVE9tKQK0cIM
	 S/vjOOsB6dfz8IXSw6usmZv5qBCV6ascDDxOUBFBKTpLMYJPnoi334rJQpEePBiFmMpCP
	 lUMy8vDhVyozZDrDteaB/xRD4eoNDIAHxGoC6UqVoJVVxA+l7t73GlOY+fINASNCCRm7D
	 aXBTbb+HJZXmOqvVipNGKxyO+NJ4DRomx9RX2znGlw0ZdhgtJ4S9wuPshpb2SgzrtvxhT
	 Rl9UqQckQ+pavjm/ThB7+EqR7P+fNvgfQ8QjKV2frlvhzlezqTYVwt9GzYi13RxNAsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XXoxZsKuevyYZll8ZzmHONzmPO9ejXiIK60yFH6ri+M=;
	b=yICIiNEC1AR02PPlEYRTudvoJahD/Dx6EpMumhFor9ihAP35IF2z3xO4FykfZq9SIkNt
	 G18U8elfq+YD5ZAfXw1pZRRu7RJKFmxIQDubfinEkCNXVlEN0qV4F7GQDxFYy9Rl8ps3L
	 B29O6mns+yFiagEYFOPm5tTZfXroV+B1NUx+pYhcE3uDdeCF9FislAMFi2OsSAkV4YJgx
	 ZRIs881tn7Eup0nd212cjd3V7SKhpZfsIY50INetY1CG+U9GFANVe1R0/WHAKlwCnTS1q
	 5HAwsFsxEU2AFBKn4tRU2rrI+lcjSkt04ea7ZkO6jt6esiXd3JDbXfosTYspzKRH2aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxES1YPa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A37606A31C;
	Thu, 26 Nov 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxES1YPa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344FC1F000C6;
	Thu, 26 Nov 2026 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795698855;
	bh=XXoxZsKuevyYZll8ZzmHONzmPO9ejXiIK60yFH6ri+M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NxES1YPadrTzuSjFLH95xulMzDrPlVR/qO5nkUFulqT+a2+gAEpNo38uyt7fMlhzR
	 t30tquB9UTjX7RV9uVLK3XIbd5ugi5PYagFzNmjxhd338lyFDjXg6AJWXWVI8fP7vq
	 ZGq6S6/ulqYfUyaZTvQVvhURoit9/1TgNsE+l2hWhx/KzopU6F7akl7jH46c89pWV1
	 eINZ88pv9f+lhigH5367+/VjWh4czDsneIVH0jDhpmzfSMdcRWfAnB8GMx0+bjC18m
	 iJhIe5Tt42mWEdxXMrdHji3+oi5C0z2yFPybv8cJXecpqAks752uvNPZA/AnCsxNLu
	 Oc82ffRPgvz4g==
Message-ID: <sashiko-outbox-235583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/18] verification/rvgen: Add support for BPF
 monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126130004.127155-17-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
 <20261126130004.127155-17-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:14:14 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] verification/rvgen: missing self.bpf in
  Dot2c.format_automaton_definition()
--

commit f6c387dbb1dd7cab260bf2fa7f3c9e7a20021e5e
Author: Gabriele Monaco <gmonaco@redhat.com>

verification/rvgen: Add support for BPF monitors

This commit adds the -b/--bpf option to rvgen to generate BPF-based
deterministic automaton monitors.

> diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification=
/rvgen/rvgen/dot2c.py
> index c6bd4d00d92e1..246b769316609 100644
> --- a/tools/verification/rvgen/rvgen/dot2c.py
> +++ b/tools/verification/rvgen/rvgen/dot2c.py
> @@ -111,10 +111,17 @@ class Dot2c(Automata):
>          min_type =3D self.get_minimun_type()
>          buff =3D []
>          buff.append(f"struct {self.struct_automaton_def} {{")
> -        buff.append(f"\tconst char *state_names[state_max{self.enum_suff=
ix}];")
> -        buff.append(f"\tconst char *event_names[event_max{self.enum_suff=
ix}];")
> -        if self.is_hybrid_automata():
> -            buff.append(f"\tconst char *env_names[env_max{self.enum_suff=
ix}];")
> +        if self.bpf:
> +            # BPF struggles with non-fixed string pointers
> +            buff.append(f"\tconst char state_names[state_max{self.enum_s=
uffix}][32];")
> +            buff.append(f"\tconst char event_names[event_max{self.enum_s=
uffix}][32];")
> +            if self.is_hybrid_automata():
> +                buff.append(f"\tconst char env_names[env_max{self.enum_s=
uffix}][32];")
> +        else:
> +            buff.append(f"\tconst char *state_names[state_max{self.enum_=
suffix}];")
> +            buff.append(f"\tconst char *event_names[event_max{self.enum_=
suffix}];")
> +            if self.is_hybrid_automata():
> +                buff.append(f"\tconst char *env_names[env_max{self.enum_=
suffix}];")

[Severity: Medium]
Does checking self.bpf here raise an AttributeError when Dot2c is
instantiated directly?

self.bpf is only initialized in RVGenerator.__init__(), which Dot2c does
not inherit from.  Running the standalone tools/verification/rvgen/dot2c
utility instantiates Dot2c directly and calls print_model_classic() ->
format_model() -> format_automaton_definition(), crashing with
"AttributeError: 'Dot2c' object has no attribute 'bpf'".  Setting
self.bpf =3D False in Dot2c.__init__() (or as a class attribute on Dot2c)
would avoid this regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126130004.1271=
55-1-gmonaco@redhat.com?part=3D16
