Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F938238C
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430648; cv=pass; b=XS/9KkmIUUv52RwkyfqPu3/P6OfIlUTyCmiEGgkq+L+2bHhRkVBCykLEOubFA3GXq0j9EqM4LEPbG/FaaeVosilVoAIzyRg141dOrNPWl3w3hZMaPg+5h3T9wB+px0laEX5gfRJSalNGespEgh/AsQNikfpll72OEHEie3HLz7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430648; c=relaxed/simple;
	bh=rTsk9Q7rhkspFsFRLH/VFkmPQ4IjUkKjQ73CU1uejN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCrG5CCkjNujitLTmv7L9/Xe+cQRWePihlT2ScQ0L3M16nE1i57klgCMD2NUEpLEQLf8qcmiVUhaCmAUGuZbF9VvywUZLqDdNuAAHTKJ3OsX330AoSrKMts66FmMd0E/Ja+VFGSLjT4f7QUoEFKa5KAJSycaQj6bgFBJHXnzzsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rN9gckdO; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN9gckdO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7986e0553bdso119038777b3.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 19:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777430646; cv=none;
        d=google.com; s=arc-20240605;
        b=GEEBK6ZOev6lAKcs6SSll1Y1vAGLCD8sfu4flqhLOQCNCI4P3sm5BT8sF/Mq3cTzjk
         fX96THJ/3dGDZs1L+o5euGRNfWH3xMkX65BAdy9FovJsK9/GR22EAtrkiRq1x0MXthbj
         sOlgYZ1jKOnxjcZSJG/g2wWPSlnkJAJ9LkH7pKElkBjUMB/r0rH+j1GFFDbL/iPyH2WX
         3rR+YUz5N7q0Wyd9eVQJysQZgIIC9mlll7pyktOEh2FyOayRB5KD40RPGWAk0UZyhQ6c
         HhA96QgDXEGX5dgHDnrCtWbSmCuCfHgoS8Qra4iZiRTN62woqOpmI9itNT5kRy8VquAS
         xggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q+KoLGDSrHSIZG6+XblKTC21gPEBzNKAEyUWN1fUvUg=;
        fh=3UZBFjDE3b3eVYTRM9i9Aqhc9ftniMlNIio9NnF+Olg=;
        b=RuumQj9M8QSG9FNCkJsu29hrpkC1/FY69DiI5mIVtdNFHwd0PXBz+q8D8YI5+xcmWd
         FBa5Tz5LC7tvXz4WKM9ZcP2kywFs/rBPWxIx+3Ncx5ldhHbdqvng4yPpJ/xcdCTwa/4K
         UxCD4E9Wbj53XBJfFP/9o+e4R6x2T+MEIWYlFAuxKef1dBZgAIbe033rax7Y3p1sGxRD
         9y7tucXHWMf85izkAxUN4L1nZTy/SOh/mV6Sd2WUrMdCfR6R3p3JGsuYZ3Sn0pnF+coj
         3K6uMWUqIpXyvOETGcOef9k/W5lWPq63LspKUwgRWS+IWPeMIEV/HKLymVAqlrWPCOLj
         +HHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777430646; x=1778035446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+KoLGDSrHSIZG6+XblKTC21gPEBzNKAEyUWN1fUvUg=;
        b=rN9gckdO21y+FjDIRIiXV4cF8LfTIP9NkunQB9xLjZPWpHwi2MdIumHUS0tBpB8RGr
         +2WW1cB1WknNACZvSuXdIhMl/L+s2TMAr9FXOQnXxPLsHCV/nWXUh0aQZLnxkzhdbpgP
         Rh0Fb1n6nE6uNT5o6UJy91eY2tM6bpruf7O2irgjNrOe2v9qJQuRyEWY2iiqeGQzJVvj
         sp9Ci41PxlpSUOjtU3LjVbuYZbXQLfhkID/tb42hI5xGDSf/85z/gRH8KyKgonp73En8
         n/dsLxxk0epCePoEXW5xEoHL6QW2n3In0VfgJHkddPLAt6qxwp2qTW/nrsQ/GlzzPmcV
         qaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777430646; x=1778035446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q+KoLGDSrHSIZG6+XblKTC21gPEBzNKAEyUWN1fUvUg=;
        b=RrTyt+ToeRiaiBmZfQu+gO9oxcIHBMU8+2QO00blfEgkKjXunqxou8fwWg7kNn8+eX
         5Gk01XMubzqxOEwO7Smt/bdF+ejoQeF/jT87E6m/QqkMD55VfMnwZxy8lNTVSnFTnjIu
         ng9RzVLiGIleGRgkaUQFe1w24ufHHz//yhyuBXW3dk8Nm0JRchqeLhTykyMMKfuH6qBF
         DyIojA+hjKwo3gwf1ZwGPAPP2Ayb0K0GvQ5nSvF3HAB3MP0lR7R8REEWrSLvpVe8sZMf
         zjdUb5ZXJdDmFRJ02oc89ZrjTDzDhCd/+pR2wFoGLZdANgEQxEY1YXjAxZkoiWHq3pOx
         EnSg==
X-Gm-Message-State: AOJu0YwAyQNt1EggnO4GkygLl2QWgfoM3oneoR2vx29IsdKZSCbCpjkf
	7opnKfVVc4aDG+Zw8QxriscEocjKt8AX/lYLdJ7xni9rDCQZnCM3k2BjuCHdlXFGAkUqkO034ZA
	lllWIcT7p4BjllzA8mP0vuixsiBOwrPI=
X-Gm-Gg: AeBDiesPrZ1BaNf2IYKqaclZSlyB27+VvbslTJFrrLTHQsNBBKE94RJ25+HSkeWq8oh
	5zNGuFX+swaCLGvpQbdfokRPECeiyU9EvsHwDAxV03Keys52pgz2c5hIzfr6e/BaaKCNs0v3mY6
	M5wPlFzPGypW6O6odEkxZDGSZyIBOP8P80vNIFB8e2Am/eZ9tbFNcjPh1dYUkRGkM4b3M+Ngsev
	KkTzsJGDFHjeMOSN0Td0AFekU5eLmzSxPOuoe4wkxwTmJbYji4HJO6XGi0GX4Uq43sJmlJ9zwyf
	KGLfWGLbwPwTlgvsEhb1PRpp5f4+IzUD/ElEk6cFvfBzQzhKIEM=
X-Received: by 2002:a05:690c:e3c4:b0:7b2:9347:7bdf with SMTP id
 00721157ae682-7bd1dab7ebbmr21814177b3.37.1777430646358; Tue, 28 Apr 2026
 19:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ia4o6j4c5y1.fsf@castle.c.googlers.com>
In-Reply-To: <7ia4o6j4c5y1.fsf@castle.c.googlers.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 29 Apr 2026 10:43:29 +0800
X-Gm-Features: AVHnY4LELreyRpJUwIYExN_byZ7hf2FVYTBc2vbJPsf4Yl0K-6feZLhlmOKYcHc
Message-ID: <CALOAHbDFvNLQi4xOBj2vvTng-vT+X42NtsCiuqHMt1PTpnxAyw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Using BPF in MM
To: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Petr Mladek <pmladek@suse.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 7:58=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> [LSF/MM/BPF TOPIC] Using BPF in MM
> ----------------------------------
>
> Over the last decade, BPF successfully penetrated into multiple kernel
> subsystems: started as a feature to filter (out) networking packets,
> it captured its place in networking, tracing, security, HID drivers,
> and scheduling. Memory management is a logical next step, and recently
> we saw a growing number of proposals in this area.
>
> In (approximately) historical order:
>   - BPF OOM
>   - BPF-based memcg stats access (landed)
>   - BPF-based NUMA balancing
>   - eBPF-mm
>   - cache_ext (BPF Page Cache)
>   - memcg_ext
>
> There are some obvious target which haven't been covered yet:
>   - BPF-driven readahead control
>   - BPF-driven KSM
>   - BPF-driven guest memory control
>
> Despite a large number of suggestions only a relatively small feature
> (query memcg statistics from BPF) made it to upstream.

We are exploring an alternative approach that leverages livepatch
combined with BPF to modularize struct_ops-based kernel hooks. This
allows us to deploy these hooks as out-of-tree modules without direct
kernel modification or the immediate need for upstreaming.

  https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao@g=
mail.com/
  https://lore.kernel.org/live-patching/20260416001628.2062468-1-song@kerne=
l.org/
  https://lore.kernel.org/bpf/CAPhsuW53pymgmFsHSkSwDvEAJ=3D+Rp2T102JYe4i9kg=
dePpR=3D6Q@mail.gmail.com/

In practice, we first introduce the BPF hooks via a livepatch and
subsequently attach BPF programs to them. Below is a recent use case
from our production environment (though not MM related) for reference:

   https://lore.kernel.org/live-patching/CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh=
1gy5hy9Yqgeo4C0iA@mail.gmail.com/

In one of our clusters, we needed to route BGP traffic through
specific NICs based on destination IP addresses. To achieve this
without service interruption, we applied a livepatch to
bond_xmit_3ad_xor_slave_get() to introduce a new hook,
bond_get_slave_hook(). We then attached a BPF program to this hook to
select the outgoing NIC by parsing the SKB. Because the destination
IPs must be adjusted on demand, a static livepatch alone was
insufficient; the BPF integration provided the necessary dynamic
flexibility.

To fully support this architecture, several work-in-progress
enhancements are being developed for both the livepatch and BPF
subsystems.

+Song, Petr (CC'd for their expertise in BPF and livepatch).

--=20
Regards
Yafang
