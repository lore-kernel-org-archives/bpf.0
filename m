Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F763EF0DD
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119894; cv=none; b=LELqf5qvKRLRlaDppauou8BBv57dymqpyliu0ls+umLqNlcnWrnyehEo4VPTXomWRAywMaNQijWPyN5RFbwLGaRiC+dy6zHBL/jZgeTXCH1vTkJ+0Jum/DIFXI4OqhyYSFdrET6ee5UcmtXd74M/PBDDYEfT3mH6EdsdE/ulKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119894; c=relaxed/simple;
	bh=BVB6qOyRBxMNYsiHGWpKXsOom98dxP4uy87qhLCgd08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xi9crRc3Ys4/7Ld6lBdTa51dCu9WCGnwLzo9iN9thjXjmeK4WFKOdLv9v4KEwzvCKrR1oYk1SspRGTbAC87OdigGjwpw+YpgH715vtS+CU4e10/D5GcIIAOrHQGKRfWrVaHAXw+fxFIJ5GJapbFaAICI4gRrMV6dZWVQ5Z9eqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju3bCLU+; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju3bCLU+"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-679f6ee3fb0so221528eaf.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772119892; x=1772724692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zyMJZ8Es71niz9QrP8bV/oTWJNPw8YbTwYsxXMHZJQ=;
        b=ju3bCLU+YzVnVYICJp/WV4fI3yJBB39rUW/NKiMHnJeAbaD6jmm5mw7/Pj/UGJFVrE
         lcua978ix3xc8IclPbdRhOn//H0wib7mHsQcEZZMyGB1Omc4lvCtI8Bu8ycBWTffm+tu
         R33cYw4fQy65MMVUT+aAd1qUwsDhg3lJaAS1B+wJRmh5qsyAW0A3Rr0GXGFYCSc7Z+Xp
         Qp0ApXRzDGPpZalfWKB8xdPe2Y/26XlV15uRxuY7DOYucFvVdjn7xW79LxbTh8IpyfzE
         1aM1+TDFhGFP65h2IANavyn8ku0nqnnt075A8nqhDx1vtZ3Z8DuVKUOiu9Ef8CjpM9Pt
         qbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119892; x=1772724692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zyMJZ8Es71niz9QrP8bV/oTWJNPw8YbTwYsxXMHZJQ=;
        b=v9mW8+xWQNcRY9QXRtMzb5xcwlTSu8WutybBk3FjkG4mszb/7yzQzKJMm5uOQT08Ik
         xKD0QG5lFUVXmVNsBwWoXzStevyDkFeyxBDTICFk++yfvl1WbsWWfnFcDooNRvADZM5M
         2MnOpJ2vgQyp/Jn/ERmAT7E20h265yO+xbtmDIl8NZRfSPbwdnkzoz1tGZCZNoQPkzWc
         T8IG3xnWEehBeiBg5tqCsn1K+Mpd8DYBxe1nZo0cECE9TSemSsHC+WNIh/O7chjn2p+k
         Hcw0XYirc1ZR7R0NSPWs/DiZ7z2dk2IdwLy4hOrZdxcFAId7zJc4txCwYK5SWmumGPZp
         +vSg==
X-Forwarded-Encrypted: i=1; AJvYcCVvFcWMVcFD601Sni0Ead8f+mpI/GH24LCRMWRWHPYHwj2eqt9Ql/u7yMt7Bmrz2WacJlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvof89dkm/sJgg1pbREsJB1TDXJVTmigbKCeR1leYMKt6s+Xh
	aKgngTycVywKl332Zfk3v49T5x1hQYioKB13ddr1Fzo+6+MzuUQs+KV+
X-Gm-Gg: ATEYQzxeCF7Q+PHivDNxZa70kCHSkmmy7otoGp6nq41uACuDYZWQPnHMrQo5EvRl4kg
	4V/1Sv0KeVts5oVLZLh8Ab6UV3HIvFOjZ1kB2nkxa0yTpnlI/Fgb8vTANaeyuTXswCS/82zFKE7
	Dk4ZRaRld9CYveuusTirGdvQo6ni6lPdMtaM6ZaoEXQsizdnbjoplRuI/qRIGeaGJ7ffiaYn+kQ
	ISd1CoKr0SdIY0G7iMtihFCKOOc94GVFVWKmD73fzaEr0KsCcV5AFuxpe42d65eNtw2mADBymmC
	JgnR+/QaQmfEHfnVM7LMcL4jJPvx0TKzZgnjyrB+3cYkcNEndHLusvK+LK2y9oGgnLJHSDOn//7
	cGfrfYgILkOi1hMcDErrT4GPJmSpzNehmzqZG68C+OQqH95bqxS4dFArJ8ny9P3ryWqjVDgQknR
	GuVOLstG4zS9lY9fFnm69cHUE4Ih8hvs2B2ez5NK2+lum2j2xxGhvoq/BO6/vyfZANqnTD0hhFp
	JuLW6XensH+wEfFBA==
X-Received: by 2002:a4a:e903:0:b0:679:dd71:db87 with SMTP id 006d021491bc7-679ef7faeb5mr2335897eaf.7.1772119891882;
        Thu, 26 Feb 2026 07:31:31 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-679f2be9ab7sm1672515eaf.4.2026.02.26.07.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:31:31 -0800 (PST)
Message-ID: <b100157c-7486-41f5-83b1-b394b181da27@gmail.com>
Date: Thu, 26 Feb 2026 08:31:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 6/9] bpf: fib_lookup: Honor oif in IPv6
 output route lookups
Content-Language: en-US
To: bot+bpf-ci@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260226080003.524935-7-idosch@nvidia.com>
 <9923d7a71f5623f84db40fa20cf3fb4e8625fc5f2661c4584dfa9237c2d98bcb@mail.kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <9923d7a71f5623f84db40fa20cf3fb4e8625fc5f2661c4584dfa9237c2d98bcb@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/26 1:41 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 0d5d5a17acb2..e92552b139b1 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -6255,6 +6255,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>>  	if (flags & BPF_FIB_LOOKUP_OUTPUT) {
>>  		fl6.flowi6_iif = 1;
>>  		oif = fl6.flowi6_oif = params->ifindex;
>> +		strict = RT6_LOOKUP_F_IFACE;
>>  	} else {
> 
> The fix itself looks correct. Since this addresses a bug that has been
> present since the original bpf_fib_lookup helper was introduced, should
> this carry a Fixes tag?
> 
> Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in kernel FIB table")

+1. I would consider this a bug fix.
