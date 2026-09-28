Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130B4B1D07
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596020; cv=none; b=OZ85AsNWE8oU+i521VwXJwwRktwwnDgslZJ0Th5cTF0dOVxaV4R42AS1RbynUJRlASCLIuw766aNgxweU7P2hJQfEj+JyTPsfi90X24sUeud/G/e3AITKreEgjYqsoSlq9Fy6ulM8Nz7Ugpe+D/HaWlF9fvgwjn5C9dW+irib+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596020; c=relaxed/simple;
	bh=wOKSbhaEYGQ9hh7wV9mhPmfPXMxl4f2uaVg1Z/kGNmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9g+WCfP3MytocjRU8enrzSONN2hWQ6mqC59xvBZ+AtKpdXzpJALWWLzKuqwk9cbYKktYNCjG1kKlOjseiIXlQe/3DAuRoTU4Norb37HJ+p+W9RhoBVhDQBhUO8eRbcyMsoLDhH4pXUslkYbdnTqZHBzbSpHBtJ9WQRqYs3bVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/UCnaFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/UCnaFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2C21F00899;
	Mon, 28 Sep 2026 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596019;
	bh=qAVikOdU4GjUYQX98YcDWmppg8naQp4CzRUYgAn2aRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G/UCnaFpyYrg/qn6Qaeap9uUtg83dXdsZbhekEXBYXyGnzV19SmniJRjU9ec++v7m
	 WAgaJDQXVbdaBBwgDLYDDfhTzU9pJ0ARi3sYQOAZIHswoYFjmeVZifTbfflDAYOsS0
	 2WW4SGW/syHs/Vxv0ZWLzh14MPXDy+WLIjVAAwN55N0t9osuUGrDsgPoKms19JLRKs
	 RfoYICuigR2+QjMf4iDa/vWatyqF5ekyDyP2NN6VdNH1BWa3o1IykDUIi4nVt4jJ8X
	 8aBJkviF4peOd0yPVu6+iUEnTAEd2nVxHyZHnSYSjE9IvoYDGArwcBuU3xOMldyze1
	 6BczgFeSvIG+g==
Message-ID: <56f0fe3f-6037-44db-b07b-179ceb12e41c@kernel.org>
Date: Mon, 28 Sep 2026 12:46:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 0/3] BTF inline functionality followups
To: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
 song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, yatsenko@meta.com
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
 <aro109AFzQhPyC7B@krava>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <aro109AFzQhPyC7B@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-28 11:39 UTC+0200 ~ Jiri Olsa <olsajiri@gmail.com>
> On Sat, Sep 26, 2026 at 06:51:10PM +0100, Alan Maguire wrote:
>> Include additional vlen/flags verification for BTF_KIND_LOC_PARAM
>> (patch 1), and add function signatures to LOCSEC entries (patch 2),
>> adjusting test to cover these (patch 3).
>>
>> Changes since v2 [1]
>>
>> - Improved flag/vlen verification to check combinations (Alexei,
>>   patch 1)
>> - Simplified overrun ellipsis printing (Quentin, patch 2)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> jirka
> 
Acked-by: Quentin Monnet <qmo@kernel.org>
