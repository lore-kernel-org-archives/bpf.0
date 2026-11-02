Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587614;
	b=g9OyDqhs6qA49gs/XPgYhYPmYJY4JrM3g84CSu7PuJm8zLLXYvHpCeZrMrAixVanRIuy
	 EFTjX0TaOTlBlOrRnHXb1HgjFUXWIdJ4ZIRKKd00posjpJUAB3BcE7oU3/hbV2Khbyqal
	 Kb8htONv0pBfZrXjOS62tGzkg//zfMD5KgQFQ4L+uzTBZQdM4zaiFRKeCCJL7YWqcYPhN
	 LOKBNRUn/Xnwht4Zsfi6E/4m0LV0/84Vh0Dg7xkRjsNvMmYHVb0SgFRh0R2mKjEHQBA3W
	 lRUoAOFE7QxgWEZ6JwMzl1tJhxZ81lqqfdWgyQzqzYx4eelJrJhjsU9jkVjTUQmw5LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587614;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ehSVwJnZsQDg84XvU5Qm6Wr9d1iEgzWRDQ26X3vNtN4=;
	b=kWfCADivP6yXSEwL1dxL4DuSahDgwgpKseaMaufeqseriHTlCG62MGygtttIha+2fvpT
	 fJL5ZMBrrnJqgp+fOpqwtXkWnoKHvUVZA7gkaxxXbrSyjgFYRt3xkHhwF4Vx2IDA77pZP
	 EvRpfN8Cn0KubQqO8ve0VwtpfPDn7EAUHdxLD1IjaMlTvF2NHZ4ohuiBXqFDyGAXuk4XZ
	 YQCHxZk+P/i3SuWTZeVrZmFcg0Qvem94+t75tZk7IHrgsSG0nwAug5KBe9PCwbk1VTTG7
	 FzRjl/VGnQOpWukav837PlRcHTTWEZD8AQWAAvhMR0kZtRQEIbw5ghlUHGBqMlLY01g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDEasyOZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6270606A324;
	Mon,  2 Nov 2026 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDEasyOZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188E21F000C1;
	Mon,  2 Nov 2026 02:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793587613;
	bh=ehSVwJnZsQDg84XvU5Qm6Wr9d1iEgzWRDQ26X3vNtN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lDEasyOZsZTGgnhZh8Px+AlBq3R8TivOBu8Fe8FadYhB+7OTHUFNkRsODjKU/ql1S
	 2p5TqhAcLpbTuCwsQRBtLmoHih5wQ+0azOX+f+5KupO0kZUT7TqD7xHrxcjA3bGjme
	 qb7wrGHJ/lb//e1nxvbBDW63ECTROjd+79HbziG4b4QQ0cQlFms/v8u3Cdqy/wclav
	 WfgdUP3n3HZpbjyaJ9h8Ibi5HihN+ZUInJHSagBYN/tWQApHEbTzLQmxtrZTllYjLA
	 0k4EfJXAn2TAINvP6d57nafE/aNx0er5HA4+VxdLqe6YMdA0qfY5wwG2W4V3J4yPSx
	 R7TuDou5+qj8A==
Message-ID: <adeb8dc8-1cc9-4297-8d34-3f4b0e2f4e8e@kernel.org>
Date: Sun, 1 Nov 2026 18:46:52 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARC: Strip libgcc debug information when generating BTF
To: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
 Sasha Levin <sashal@kernel.org>, linux-snps-arc@lists.infradead.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>
References: <20261015154044.4058618-1-sashal@kernel.org>
 <09db4d22-2836-4656-8c6a-a7e5377710fb@kernel.org>
 <8b4688ca-db5c-4122-b616-8e3964e403f8@app.fastmail.com>
 <7de128f0-4f17-4a33-9a7a-14d5bbf62e64@kernel.org>
 <ca697a3c-fee0-40a9-98e6-12e24febb3b7@app.fastmail.com>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <ca697a3c-fee0-40a9-98e6-12e24febb3b7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/26 11:45, Arnd Bergmann wrote:
>> Oh that fits the bill perfectly. Mine also switched the others (with
>> build test using their cross tool-chains).
>> Anyhow I'll wait for that to land. Would this need to wait full cycle ?
>> If it can land in 7.4-rcX, I can hold off my existing patches for
>> switching to current in-tree lib/* to also use the new ones and be done
>> with libgcc.
> If you need this to fix the regression, I think it's fine to merge
> the shared lib/*.c files for for 7.4 along with whatever you need on
> top. I suspect though based on Sasha's patch, the only thing we
> actually need is to stop exporting the floating point functions
> so the types don't leak into btf. If you can verify that this
> is the case, I would do the full conversion for both nios2
> and arc in 7.5.

Yeah Sasha's fix works w/o eliding the FP routines (there's an unrelated 
issue which I send a fix for [1])

As of 7.4-rc1, I have 2 ARC only changes to
1. Switch to existing in-tree GENERIC_LIB*
2. Dropping FP symbols

I can post them now. Once Simon's changes land, lefover ARC conversion 
and and removal of libgcc can all go together via your tree if that's OK 
with you.

Thx,
-Vineet

[1] 
https://lore.kernel.org/bpf/20261102023638.1621622-1-vgupta@kernel.org/T/#u
