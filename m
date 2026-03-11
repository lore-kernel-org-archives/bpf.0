Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA132572F
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207419; cv=none; b=u4/zfC2lDoT8fnVHA+ckIzvUXPd2FzDNONKmKB477kHywd3I99xWre/KT6NfAvJcBhzEJH9G/g+WPcIowXRbjaDIfKlJQpJM34of0JrBtqexnkiFttmXZe6Hl78BzEFEMEi0LBtEPLkbswwO+gSm3KMjnwy7FYRgonUlAMCbPxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207419; c=relaxed/simple;
	bh=9CEB/74WFFjTifqZ47oKpZsD1XFNTSMg+BOBSEWYtZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HT6ULSw4ZRpTtnvA/qMORQxZqib3WFIT/3CrI9/2XEP3zEGJCjm/Qb1bc/ZUonXgVxoTyycWp3Zlklg8sHSNPxaook42EhnxrreIvAiZ5m/b+d0TjudIP2nPhRFjxlg46oZCCiklX1QxpKxNxgj21xBkl80BPPX5qrzwVb4bYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7C4TpIZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7C4TpIZ"
Message-ID: <23d2b1c3-aafd-4af1-8511-a74a1cd06ef3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773207405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0gtpXxGfNR+MD/IgS5H10hgKO6EY07tpIe2SjFnx0Y=;
	b=E7C4TpIZHh/fgoc/rLFL9L4+bbJ2rnh07q7AORCEoEH1dZnNH56SuLiFFfSFCgOFAghQ3F
	33UR3olFt4ezVIaBy7MzkxGHxbohIKLmR7sPkhvgrDVbgIQT1baQzbunkc4p2ti72sVBrG
	ObH8s6mYjMaK1ZWpKRcvSAjjDEPf6yQ=
Date: Wed, 11 Mar 2026 13:36:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 5/5] bpf: refactor kfunc checks using
 table-driven approach in verifier
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308134614.29711-1-pilgrimtao@gmail.com>
 <20260308134614.29711-6-pilgrimtao@gmail.com>
 <4f18c782-a09e-4584-8abb-0c81265840ad@linux.dev>
 <CAP01T74Xbg9HiGA6qwPzkOnaq5XfGu_MA+bKX6g-OE9UwOoboQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAP01T74Xbg9HiGA6qwPzkOnaq5XfGu_MA+bKX6g-OE9UwOoboQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/3/26 04:10, Kumar Kartikeya Dwivedi wrote:
> On Mon, 9 Mar 2026 at 07:45, Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 8/3/26 21:46, Chengkaitao wrote:
>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>
>>> Replace per-kfunc btf_id chains in list/rbtree/res_lock and graph node
>>> checks with btf_id_in_kfunc_table() and static kfunc tables for easier
>>> maintenance.
>>>
>>
>> Such refactoring should be the first patch? Less churn. Then, update the
>> list only.
>>
>> However, is_bpf_rbtree_api_kfunc(), is_bpf_res_spin_lock_kfunc(), and
>> BPF_RB_NODE should be excluded, because you didn't touch them in this
>> series.
> 
> I think moving clean up earlier makes some sense, but why exclude
> rbtree and res spin lock?
> Looks better to me to do them all.
> 

Okay. Acceptable for me to keep them.

Thanks,
Leon

