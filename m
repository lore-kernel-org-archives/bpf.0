Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB84D17B3
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676307; cv=none; b=Z6g5Ytb4uSNHa4IpGt5YVAR/EhV4cZT7hzsOOH6ommOqbWVyJHMib6bBIeUa3LHm6WLhGU7ZkIinmHgST9tqyPMobrjPrhoUxOhOlcq0R8XLI1sFplvflxjqGvHnOOul9RcMCupf4DAHUwtvEYw0TYljNHIe1RNTJ4WcDHR+amc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676307; c=relaxed/simple;
	bh=S/TfmDEwWXgYRTxttGFKNIBuFQrhbKIHhXiT92KdjgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trwtIF7vO9KeBJv16TBT3Bpk/o3N6/t/SvxhBncACbSeXGjXmTg3RwdNgWmBNJN3ePhIVI/2CQju/IT5KPT/3tGyO+ADpJpP5m+JF8oHtB9Zl89CFUih2vGSbrBBXB02gNUJzS9UpnMeGEu26Bzqj5oRhm5sbrMhJZSRNT+tQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yyqqw2Pv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yyqqw2Pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E251F000FF;
	Thu, 17 Sep 2026 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789676301;
	bh=RkZSZf/L/z7gLoab5aIVFQarS1LHtXM5n3u/r9WuA+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yyqqw2PvlX30yzk7k9rDTci/ptifaJUt8uAl47GaUVoy5sYKLVWyclZZancaP2h8L
	 3h/KMcl4QetBt0fUFqXy383LdWzk0KCzLAL+B6Tsgqm3qOQcXWRGM8rop5IN49WRuC
	 PCAiRxu/tV3+5swhYSLx9Yt+9w8YDNGtYZdykffOBE8joFNE5+WhcwAbRoVF5vZOCf
	 D+FdeoVW7zbYYOQXOYEA/jsrZ+cJFG4kD5A3N9Etk27d90OF9Zo89kC3q3cIRlok7u
	 /473WF0TbUEHnkRZq0h1X9hljpWlzPqLHSPYytS/9sFAD6FeGuqk0NsWzRUhx4zH17
	 pFvTpKw2tMj2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 03/15] bpf: Add bpf_struct_ops accessor
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917200542.3689605-4-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
 <20260917200542.3689605-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 20:18:21 +0000
Message-Id: <20260917201821.C0E251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: bpf_struct_ops_id() fallback stub misses const qualifier
--

commit 4cb7f791fab01ff62552075c9ebcbd1da5be37a5
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Add bpf_struct_ops accessor helpers

This commit adds helper functions bpf_struct_ops_map_kdata() and
bpf_struct_ops_map_cfi_stubs(), and exposes bpf_struct_ops_valid_to_reg().
It also refactors link update validation into a new function
bpf_struct_ops_link_update_check() to be reused in cgroup.c.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1198404885c86..90ab467d25a27 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -2354,6 +2359,28 @@ static inline void bpf_map_struct_ops_info_fill(st=
ruct bpf_map_info *info, struc
>  static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_des=
c *st_ops_desc)
>  {
>  }
> +static inline u32 bpf_struct_ops_id(void *kdata)
> +{
> +	return 0;
> +}

[Severity: Low]
Does this fallback stub miss the const qualifier?

The primary declaration for bpf_struct_ops_id() in include/linux/bpf.h uses
const void *kdata. Passing a const void * to this API will compile cleanly =
on
enabled configurations but fail with a -Wdiscarded-qualifiers error on disa=
bled
configurations where this fallback stub is used.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917200542.3689=
605-1-ameryhung@gmail.com?part=3D3
