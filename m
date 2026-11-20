Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187852;
	b=uh7SkNhiRebAAHMhLICbBTnjw0cAB9aZmzvvX20YAzeAO1hWDSzeHe1sg1GhlSiD2mhA
	 uqQmNlJZfG7Ui2H87EYyHSW8VgshJYdIdYkFT5LGFB2klvRAvkeBT8V9VF5cxh0U8nYut
	 fnjQ2Q7hysaACWYgHos/uGM4o2rOxIYIXErB7i/jXUxvC4iu2CPKEriiGGFMBNm/J5OR4
	 r6cMhIU0R3xsiycrEL+daoMDGoILMPppw6FoXIw4bVH0FDa66J/JcJXNqFdJn2mOWsGPh
	 xumyWA1jcAgHBT0Ja36FxQpN/8wka8G1VD7nVJHpgUYKmcvLFXVeHsexZltMQ3Qc0NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dmbMKKC7rHPR8z5diAydnlP9jK6mYRhdlxvy7H5liH4=;
	b=wfY7i3C8SvmjIn+4UQGHBOYYRnkAUuLjz2WeWT3RQ8aMH8+6CiIIV+xcbS8gACddUt9W
	 k6r55M0ahflFD9yZJ/8eLVAieVX/5LXZFk0cdfxq36qMgMS8Cv56vVGhR3RcvQEc+PFCE
	 zDbndNwFg7hLGQgduXYek2uXwf6AtBb2tVnmXIShEkrOYKY0rj0vOx+H0b+r6iLjgleV8
	 31gHTL0GQwOalSgLcFh6ZIOhUxQcpl4uzfzcxZfdFY7jy6MrHp/ij8iMLMfDS9Am1P8K3
	 9Q2P3ky/uz2XmKK6zn2x6fgK6NFde2uuagOC85GTq9OUGOhA1BkUmas1kaAS7TceTWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGktkx2f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A9606A32A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGktkx2f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC441F000C6;
	Fri, 20 Nov 2026 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795187852;
	bh=dmbMKKC7rHPR8z5diAydnlP9jK6mYRhdlxvy7H5liH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGktkx2fgM8Ou6BrHhu2+3ILBwHUT1hf50XO6E7eL8YLAGBRXp/EzUsBPbYpp3vw1
	 nFO67zXhzUj99prudR1sWffY3eqyqTznu0rCe8BuhBlN0a4KkhDq+HeSVE41jjvyFE
	 Jt3aheaILapHi6lDfrRjAiVe2ZMl9epnwy3E9ISSXwrZOH5qOFtdSTcUwzq6+/Geav
	 1EwsKvjL/y4tIXdGMHO464YIRuGqG8RLJTX1XaZh8fCPb3gWIkxTjsWLAVAbU3qZIf
	 5BvPckdXNbbACbHy1YRXVTuDWer22e7Mi9cZ8O5VkeHAba1/9vxLBVg9kgDLrKNTSL
	 wDzIP0yY5FSlA==
Message-ID: <sashiko-outbox-225447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 1/2] i40e: wait for one RCU grace period in
 i40e_down(), not one per queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shitalkumar Gandhi" <shital.gandhi45@gmail.com>, intel-wired-lan@lists.osuosl.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20261120150527.14649-2-shital.gandhi45@gmail.com>
References: <20261120150527.14649-1-shital.gandhi45@gmail.com>
 <20261120150527.14649-2-shital.gandhi45@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:17:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] i40e: unpaired napi_disable() in i40e_vsi_open() [1]
--

commit e3081b5b3e5283a7fdd835e0d6be52ee866385e0
Author: Shitalkumar Gandhi <shital.gandhi45@gmail.com>

i40e: wait for one RCU grace period in i40e_down(), not one per queue

This commit moves the RCU wait in i40e_down() out of the per-queue loop
and replaces synchronize_rcu() with a single synchronize_net() call when
XDP is enabled.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index 98d2fcdcee68f..e0c76ba566ea5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -7609,15 +7609,18 @@ void i40e_down(struct i40e_vsi *vsi)
>  		i40e_force_link_state(vsi->back, false);
>  	i40e_napi_disable_all(vsi);

[Severity: High]
This problem wasn't introduced by this patch, but can
i40e_napi_disable_all() hang here when i40e_vsi_open() fails in
i40e_up_complete() [1]?

If i40e_vsi_start_rings() fails in i40e_up_complete(), it returns before
i40e_napi_enable_all() runs:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_up_complete() {
	...
	err =3D i40e_vsi_start_rings(vsi);
	if (err)
		return err;

	clear_bit(__I40E_VSI_DOWN, vsi->state);
	i40e_napi_enable_all(vsi);
	...
}

The err_up_complete error path in i40e_vsi_open() then calls i40e_down() ->
i40e_napi_disable_all() -> napi_disable() on NAPI instances where
NAPIF_STATE_SCHED and NAPIF_STATE_NPSVC were never cleared by
napi_enable(), sleeping forever while holding rtnl_lock().

[1] https://sashiko.dev/#/bug/linux-f4bedeae-9add-4cf7-9ab5-6f1f169023a5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120150527.1464=
9-1-shital.gandhi45@gmail.com?part=3D1
