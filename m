Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942A22083;
	Sat, 11 Jul 2026 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783813162; cv=none; b=ZApbgpXYLo4kxmU8LbxirZYYThaajcDRc/SV9Xv41wY9u9lABOxJHfP6iyfAus4IQ94kiPyHARJpDFo8DlcnnIP7YaTYD8vPDutLU5TaM4INVngxNOHeWr8lYhrU8E/iQjZyvqqfTdwICXHkziLa+osKgsUsokvby3OoifVTIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783813162; c=relaxed/simple;
	bh=Ix6EaQ4AZEKzYnQtBJLPhEhMiHnwivHrSizMAEPrzVw=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date; b=mdt1ycNoK1eoXoi1F7uSsn4bNF2BzK3wvJeSYIqSYpDcR+CZxGu9XxTq2/TXlsxk9QU8MRLhjV+JnLKEeTEcmx0r8xQIfy5U53ZnblQGGkwG3T4WF3Ynn8VxR+lp8oDKvU8yZa+o011sZsaxkjNGN9BBk+6hfMbtqbpeJJGKQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gICOflyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gICOflyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F771F000E9;
	Sat, 11 Jul 2026 23:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783813161;
	bh=6rTitmnwB3slWkXkkO06jq9wjcjVhrdMYERBFoHzaew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gICOflyv39hhIh2BVE9kY0OBaVfPjYFRGkxRrJkSOUDBrjkaY9FRgVvEvEOV5fG7C
	 QpHtyvd/xXcx0AmizvllQz97s1Pe8hN4S0aPoh2x4CH22rKNL2DUhghEHPiOWW2Q5E
	 ktqIBlYQvXhdvY49znv0bm4rU+ov2eQLawbOMoMyrQeVICPTrg7/vS0vY+eqh+K19e
	 MDWv9/ChmmdPY3/M8kGjejYfec1GEta7AoMIKuO0b1uOpTSHrAkwc/xRDzGeSTjttI
	 CeJhATAnYZNcXkgEwSKjQ0pvEzubpElVwfeUQLXi6Nz/6gYWctzDpbJwV+xjNs8HB3
	 9cmpp3RP2v5gA==
Message-ID: <bb17a525f0f0a42a1678f117177f0a17@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Nicholas Dudar <main.kalliope@gmail.com>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, emil@etsalapatis.com, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 0/2] bpf: require an owned cpumask for bpf_cpumask_populate()
In-Reply-To: <DJV4SE3UC9L5.2MM3IGLHLQICW@gmail.com>
References: <20260709182800.2037938-1-main.kalliope@gmail.com> <DJV4SE3UC9L5.2MM3IGLHLQICW@gmail.com>
Date: Sat, 11 Jul 2026 13:38:09 -1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Fri, Jul 10, 2026 at 09:17:08PM +0200, Kumar Kartikeya Dwivedi wrote:
> Hi sched-ext folks, this fix looks good to me and on cursory look, apart from
> potential signature change which may require some adjustment to casts, it should
> not break existing intendended usage.
>
> Could others confirm this? Thanks

AFAICS, this shouldn't break anything.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
