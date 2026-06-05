Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77083955D1
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682690; cv=none; b=KkburXAF+O3/0IJSBWr/WqYEMKPV/7Wm0Ukgo15EOtyaC9Xrhxx5AMkhhmwYfhCz4/hB36Ut31f4ovsewspCYSfQQ/3t8Qxhh1Yb919VQxKA7rFKzuu959ShAZgvCOBqJHmfEqEvA0Srr2WEMFRxuT1RpeSxXfrYwgPlLy+Yua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682690; c=relaxed/simple;
	bh=uDPXClG26mRl8codStFyXHpgtoT2oAJseE54IApEFz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iirXapbTuScsPxRuUdNRxUO+GvUxsvJ6cP+oddoixtlxdqcSV2JghRhhIrQEeKhtyeBqypibe6Ai1iWnsq5Ev3gMFG1dbscHXaDZYlVGcJWc53QgL6Fl5ciDMO21OZGWgzfMPvVdeVCd5uvRTBJ1hxyLc7hdB6GlvtnAxl3cJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LekKrEw9; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LekKrEw9"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13810b63a1aso925438c88.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682688; x=1781287488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uDPXClG26mRl8codStFyXHpgtoT2oAJseE54IApEFz0=;
        b=LekKrEw9WAGy/tFBd0BZ3fek2GaPXFE5u2qMWwKks7gySUqjjGbzAtUl9xetvogzDE
         PFw+THltW+hZClna5gYfsACGVBAMIv8gMAVACBblrsotzYBIrBTokXxXG5Dp7xdx0yR/
         PANW/VNBniI7tOqhyJZsSzqRovsAQ6pvZp9inpSd2assXjoRTNdR3BzGaF5qveO6PxUz
         SdwzRm4Yntz2zTzEstziTiIKm1z/Dtj/fMwS3vyvQ6/pd6/YtM3b7SMBJ0d2UUJ9/POs
         T2cGyRDQhKitDoyF7gLEbnUjs5UCAV64H7uywPIItkWl94Hh4lbYBm/poE68zVo71rq9
         dVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682688; x=1781287488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDPXClG26mRl8codStFyXHpgtoT2oAJseE54IApEFz0=;
        b=i92nQZpEA9zeipmXge82/WqYaWaJdLKOjsVJyO59KslP6um3PPhXqxcdpmZCJGm1Es
         YltYHxlnPeuGeQQBFDN7C7ClOi2QXX+fCK5bfqQZRWKx+42mGW7HCm83oQpZSfFIQxJp
         3/WR/hFvpyeS4Zdgkretm1+BsSIusHL/GUz0li6PpgEfUSW4JS4sDzHUZ6pWpQwuDYyM
         JCaIWWrmMQc8keauszVHq/osQrAAM0vMF++/dxsyF5QOZxgmrc5EuZ+DOchPQdCeEZPQ
         5pL6tFhgdh8oMdvm/RS7QTAZVnNc3dEFZohuGhu6w46ZpQghDIpggzrmNxJLfyNO4ER+
         y9nw==
X-Forwarded-Encrypted: i=1; AFNElJ+QwJ4g3hvZXheiDB5dvgHoAA/n7dN5P6stLtB+6rHlloesh6RYv5iTk0iFTa8ZVHmUPuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmGB3b5t57eWmDB60o1pupj3hx2KG5YEpiQmW+nonR3T5C5Tt
	+ED3CieNvgPZgPidowhNeTg1kAzrP9n4/EKUtn0WTvxmWPENk09pfIWv
X-Gm-Gg: Acq92OFl4ASezQmQ6oJcd5T7rvWScLpWhUrm/tw36uN/79dCwPSAyikxL9HWBwWT1Wa
	Frg5XUm7y0JvbDs7ITQ+VVRQkwS+6hn/YZEph/5UMN5JMMKexexMRx3s8orLmcwcbJFjpDTzEmO
	nD9vQsp8ytEm8BDSyofgM1f8EPscokQtFi6rAh7oVw/1ZH8wR9Rg/kZvt2oArNEXUV9BG3ilAjt
	V/8M5tuu5R3CYNlIKbHiErRlriifkwv85SU1HwyMXIh0nXynKUQ1O6sdgk9+rwPpyjlf06gKXnQ
	ua1/EQLz/rhGTStfxjtZYUFWOya/w5qdyiU9MdBTNl31zvQFNxPQ6A9UK1Xz6OeD0fbMkWGyOUO
	8uGC/K5Ssdx+vt/qgTME/fGuWD8NR/nxQ5/YoG6dL4+pnFyKpTHCqvEUSK6WfvMBe4mBT/gwGSE
	8rXFxsskrwdvmAJpcq5N+tzRWm/PnMv4WtHLRx0CN+C+E9RNZNSmdIqiUluRVPjuBDekhJbWIXX
	ItAwLgXVAcLIK+6Qq4=
X-Received: by 2002:a05:7022:6999:b0:137:e45d:7c4a with SMTP id a92af1059eb24-13806720d38mr2287079c88.29.1780682687836;
        Fri, 05 Jun 2026 11:04:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5897:d7ae:d523:2a3f? ([2620:10d:c090:500::2:ccae])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm8936565c88.15.2026.06.05.11.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:04:46 -0700 (PDT)
Message-ID: <6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for
 REF_TYPE_PTR
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Fri, 05 Jun 2026 11:04:44 -0700
In-Reply-To: <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com>
References: <20260604220904.1032145-3-ameryhung@gmail.com>
	 <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
	 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
	 <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
	 <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 10:57 -0700, Amery Hung wrote:

[...]

> Actually, looking at it a bit more. I think I would hold on changing
> check_ids().
>=20
> This patch should not increase idmap usage. parent_id refers to id and
> therefore check_ids(parent_id) will reuse an existing slot.
>=20
> The id_map is indeed more likely to be triggered since there is also
> an intermediate reference for reference dynptr introduce during the
> refactor, but that should still be very unlikely under normal usage.
> check_ids() also already fails in this scenario by returning false. So
> overall, I am not sure if we need to change it.
>=20
> WDYT?

I agree that it should be fine to just return false from check_ids()
if there is no space in the idmap. However, since not all ids
correspond to register/stack slots anymore, I think that
WARN_ON_ONCE(1) should be removed.
