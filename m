Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919539D6DD
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919276; cv=none; b=QH5baUQ/YDsbGaOKPcBxngX13Bu0a+oXO02PZ200V8QVdDo2ViBbQu+77bTln0xA4MRV8FDhDALyLILZ/DEAZq+lsDiiWTHdMNzk6WVLOZbZwOEoINbXqEbsVwPnVmi8IUSPlTkDtr7NDJAYo+9XyaByOndV6J+30NmmSti9Sn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919276; c=relaxed/simple;
	bh=Q61VXIaQXkenKNM+77TxCQrN29YylvClM+n21KWbbmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEQoFMUnOB44Z+xeopTE6kR8dYP7glUZF4dyX3HXWNqrdPWGDKKzpigPmCPz8UjIRjT5DLbtWDXVUDuF9g46OxIAxtIeentB/PC+XcnAbaxI038Wdjgb20hraK/zig/lVOohBOSBD6pYn63LaLcZ3uRKtvDVcD1DiKEebUrQNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=J8Ta/WV9; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="J8Ta/WV9"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CF3E282D83;
	Fri, 02 Oct 2026 07:34:30 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9xWk3-7675H; Fri,  2 Oct 2026 07:34:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790919270; bh=Q61VXIaQXkenKNM+77TxCQrN29YylvClM+n21KWbbmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J8Ta/WV9XdsvSJ7JQTHKBYMR24ZDBMPwRJb5v7BDEKOdvr0+Odu1ze4fVd+LXnNW7
	 Siu5D8ZVxCib6c4BWfWhEpQxFfoGeAPFpN4AtTgjYPXdnLbm4tJN0JLqBMe3ZdiVke
	 l3ro2DMq0N5qBGF7gfi7EeC0N4SJlaVPvQekkBkY1p2x67k+9ZtS3UT9V69Mhyg08M
	 pppB6LKf7FSv60Von70c1QZxU4EIe3mxq0mXnrdTx2LRGxhqI+ck/qvEOhjVKnPp7q
	 Tp7Xw5q8wUcUYKj4teLiHXMT8UuMRJ4FYNcI4Z+1iSqqR8FjVKKaxrO/PyX2BdMzsK
	 zAbLs7NRd5BdA==
Message-ID: <23576cbe-0d23-4478-99cc-0e7fbb7b4001@disroot.org>
Date: Fri, 2 Oct 2026 06:34:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bpf: Fix incorrect handling of user flags by
 percpu map updates
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20260930135753.1063495-1-maghasi@disroot.org>
 <20260930135753.1063495-2-maghasi@disroot.org>
 <bd1e4297-347f-4f0c-a1aa-9a750e3e353b@linux.dev>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <bd1e4297-347f-4f0c-a1aa-9a750e3e353b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2026 16:16, Leon Hwang wrote:
> Hi Masoud,
> 
> Thanks for the fix.
> 
> Pls add target tree in subject, like
> [PATCH bpf v3 ...] bpf: ...
> 

> 
> I'd like to split this patch into two patches: one for lru_/percpu_hash
> maps, another one for percpu_array maps.
> 
> Is there similar issue to percpu_cgroup_storage maps?
> 
> Thanks,
> Leon
> 
>> [...]


Thanks for your time and review.

I will apply your notes to v3.
Regarding the percpu_cgroup_storage update, it checks flags differently
and I did not notice any issues with the way it handles flags.
