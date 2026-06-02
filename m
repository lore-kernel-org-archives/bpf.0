Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E338F621;
	Tue,  2 Jun 2026 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424732; cv=none; b=d+o7oYJet6BCMrAu1HpHl52hPxrnOqtjJUd4M5qfO3IOe/b6xDXS3tCWS9JwA1YtFkLYi1ESrZHNNqI/fR9uIqeCh6HtQQUvDoe8prQU6lur6b7g2gzFenJV71n4Rn0KNNwtADSCXtd5LCjELc6EMfSVhau2s/AwfW0Ou3yhkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424732; c=relaxed/simple;
	bh=m2ww0XwDBOk+X/DJHxV5Rke6QMTqapTDOURbIyYF0dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIxshve58t7l12w2ZkaomPwWcz3Gp9SmXnb0xtDb81ym4mVSfkoIJI+eu4xx1dNoOBgXZioZ8+9VemiEA+4e2v5W/p4ZqO0x+kRzN7iXUPAyr9b3tYqeJXmRtxn/po5+YreyIyFoiQ0VQGuz3LRMTlIUT60mLjaZEQ3K0bJ/U28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G5nm3PhD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G5nm3PhD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TlQYIaFbd8Scw/+AzqTQugiq7PeSZ5QIF5QB84Lxn6I=; b=G5nm3PhDzoukqkkl5y3z5zz7E0
	9AAs+RzBrjQSU4NUHq5mI96OM3vKgjR2al+lv8+MtHReTu2YKcwPjPEo7NrbyVyD4za9lRCVaScK2
	ETU/nx7bUX0/Wr9Hzo47hV7Y0qkHvblKHoGGMtwF5Y+rcgrPWYphGc2pEA2ngs69Sta0MNbhEfvc6
	xYVzsFBjWiFtS5hwSj2HEZVPHFP8NzJir1Y5/8Bc+Vs+k4D231TuK+aZj+N/SvA6eJgYi0Ma+CcHD
	nFQ5JoLrSMsXVtNq9lhNXgvhm8gT1ejW9KBXSnYxkDxG4K63WtUQIA5aCqxF7mFauiUM2WaLMN1Xb
	qYSp9AlA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUTnk-000JdG-1g;
	Tue, 02 Jun 2026 20:25:20 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUTnk-000O1P-0l;
	Tue, 02 Jun 2026 20:25:19 +0200
Message-ID: <45b4549a-d8d3-463d-b20b-67decb592bdd@iogearbox.net>
Date: Tue, 2 Jun 2026 20:25:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/vfs-7.2.xattr v3] bpf: Add simple xattr support to
 bpffs
To: bot+bpf-ci@kernel.org, brauner@kernel.org
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260602074012.416289-1-daniel@iogearbox.net>
 <2d6910a31663ac3d869938f85fe1dd523be21d30ebbde644222275122cf4e678@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <2d6910a31663ac3d869938f85fe1dd523be21d30ebbde644222275122cf4e678@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28019/Tue Jun  2 08:33:27 2026)

On 6/2/26 8:07 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/fs/xattr.c b/fs/xattr.c
>> index 09ecbaaa1660..a7abb39f0041 100644
>> --- a/fs/xattr.c
>> +++ b/fs/xattr.c
>> @@ -1689,6 +1689,39 @@ static void simple_xattr_ht_free(void *ptr, void *arg)
>>   	simple_xattr_free(xattr);
>>   }
>>
>> +/**
>> + * simple_xattr_add_limited - add an xattr object, charging per-inode limits
>> + * @cache: anchor for the hash table
>> + * @xattrs: the header of the xattr object
>> + * @limits: per-inode limit counters
>> + * @new_xattr: the xattr object to add
>> + *
>> + * Like simple_xattr_add(), but also accounts @new_xattr against @limits so
>> + * that a later removal or replacement of it through simple_xattr_set_limited()
>> + * decrements counters that were actually incremented, rather than underflowing
>> + * them. Use this instead of simple_xattr_add() when seeding initial xattrs
>> + * that share a namespace with the limited set/remove path.
>> + *
>> + * Return: On success zero is returned. On failure a negative error code is
>> + * returned.
>> + */
>> +int simple_xattr_add_limited(struct simple_xattr_cache *cache,
>> +			     struct list_head *xattrs,
>> +			     struct simple_xattr_limits *limits,
>> +			     struct simple_xattr *new_xattr)
>> +{
>> +	int err;
>> +
>> +	err = simple_xattr_limits_inc(limits, new_xattr->size);
>> +	if (err)
>> +		return err;
>> +
>> +	err = simple_xattr_add(cache, xattrs, new_xattr);
>> +	if (err)
>> +		simple_xattr_limits_dec(limits, new_xattr->size);
>> +	return err;
>> +}
> 
> Does simple_xattr_add() accept three arguments here? Looking at the existing
> simple_xattr_add() signature in include/linux/xattr.h:
> 
> int simple_xattr_add(struct simple_xattrs *xattrs,
> 		     struct simple_xattr *new_xattr);
(this is on top of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.2.xattr)
