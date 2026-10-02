Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17C3BB11A
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919950; cv=none; b=FG0D9P+y/G6Ub1FQA8WfPvA7p03zvRyhD9o6JvrbHm3R8efOsD5LJSIbyhX8Gm8guQaO2/Tg+X1snYadNchFcIPfTJRpyIru3lNg5MU1MUgGXbqm/A1tRCdqfAQlv3H9sZuVvl9nIksRTYGeZzXgO9uwm6Ae8bGvJkl+jc/b3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919950; c=relaxed/simple;
	bh=uJ+SNW/tbjbPoGKWTgS/XcIEgO6gpNLQlLOXXW3gfGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRiI2PhP1eceHuNJLMk5qAW2aPB7qb/DvcfDp58tmxsbl5YbkyGPmoaFnO4NhXkg+3+LbVq2K3vntOpllS7KtNNKitpPpX9c09QvJgq8nCH0plcldW6xmPCOoV9PMtO7emFRs53i9kmi+X95fL+rAzHz8YUTMiDVIW1CojRdSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PEbc/TmE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PEbc/TmE"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 94EB382D1F;
	Fri, 02 Oct 2026 07:45:47 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0tVLoZnzgSO; Fri,  2 Oct 2026 07:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790919947; bh=uJ+SNW/tbjbPoGKWTgS/XcIEgO6gpNLQlLOXXW3gfGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PEbc/TmEYce87M9MrBDeCOZOzBsAoAE91WiRpCQdg47tsnieXw1o2XgHNLwK+YtAI
	 xhz1BX4hr2zM98oYclXtQEylEmK9MlRtYVldIC9IVXETed8kamIsoZDctDE0XVpWb6
	 PoSPlcUhoMyoDRdPHQB0Wtl6fFdxkfuLhD1ylbzCCZEvTqwAl2ZLHFXy1ZiAtmeK/V
	 Zq7hAw8Y+7UZJQt0SS23iH5iQ7sV7xc/XZZOoY/tixQZqxYMhjdDW+66kGG4AHf1aR
	 X3QoMiDmKfTnxam0ztmOCUIX2rJPGKfZkFmG508Za4r9TQS7C6OVE6nbYngivuv8Mb
	 r4mz0YN8K1YAw==
Message-ID: <3e798ddc-0a8f-4cba-8ab9-f65ba5da90da@disroot.org>
Date: Fri, 2 Oct 2026 06:45:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/bpf: add test for percpu map flags
 combination
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, leon.hwang@linux.dev
References: <20260930135753.1063495-1-maghasi@disroot.org>
 <20260930135753.1063495-3-maghasi@disroot.org>
 <DLTM3D36ENNF.3IH79JXEGYZAX@gmail.com>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <DLTM3D36ENNF.3IH79JXEGYZAX@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2026 16:37, Alexei Starovoitov wrote:
> On Wed, Sep 30, 2026 at 02:57 PM Masoud Aghasi <maghasi@disroot.org> wrote:
>> +	flags = BPF_F_CPU | BPF_EXIST;
>> +	err = bpf_map_update_elem(map_fd, &key, &val, flags);
>> +	ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem flags_combo");
> 
> The map is empty, so lru_percpu_hash test passes without
> the __htab_lru_percpu_map_update_elem() hunk that v2 added to patch 1.
> The check_flags() change alone is enough to get -ENOENT.
> Insert the key first and then update it with BPF_F_CPU | BPF_EXIST.
> With max_entries == 1 prealloc_lru_pop() evicts that key and
> the update fails with -ENOENT without that hunk.
> 
> percpu_array changes are not tested at all.
> Not even BPF_F_ALL_CPUS | BPF_EXIST from the commit log of patch 1.
> 
> pw-bot: cr

Thanks for your time and review.

I will add test coverage for all my changes to v3.

Regarding the v2 change in __htab_lru_percpu_map_update_elem(),
you are right in case of empty map or max_entries 1.
But consider this scenario: an lru map with max_entries 2, first
inserting key1 then inserting key2 and then calling update on key2 with
(BPF_F_CPU | BPF_EXIST) flags. without v2 change, this sequence cause
the unnecessary deletion of key1 by prealloc_lru_pop(). But with the v2
change, no key get deleted unnecessarily in all cases.

I will include this scenario to testcases as well.
