Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9971279DC9
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214337; cv=none; b=i37NfJZ/YJOm907kDwb9nm6iA7RTHVYw+xuEjzEza7NIUIclJfIhvpNwAhYXJImn+MK6AkQA6wh1wVqplmyaerX1IK0guy4XDg+UP9oNs9gnv0bYL7g1Cry3kVthtEQgc4jxtcR1NpRorIM6bnGWMCne320swjPByBQodFFnDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214337; c=relaxed/simple;
	bh=TWJOGOxVkpA6pYHt2k538f4kz5NIK8nh1QpbIqUzmpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBCC5NUyrbuSnTCv0J+EFYf6F1ro+84nxOs0SdwnI+J255ZCt6QA6XPo/6qmoy0OCg4YZKAz8JXkirvtS8JDdYyxrvOLV2XPi8SoBWGFfkyR8avkNdq+w265SoWFlvuWQd2SLWBIRfuL08gn+Rts+bqtdJcK3bFw2agoMphkJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=c9TXeOPl; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="c9TXeOPl"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137335bc3caso463917c88.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781214336; x=1781819136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykQKgx44w3X2k/qU7oxMtTqbK/zBreaZPe3qMH5/aXg=;
        b=c9TXeOPli3AVUUHXMKHoKh0ZJm/vYEW8IDs92gcSyG4niUUrB+J0KIRJRQYwNkXQNn
         8Pcbg4eIJ8MVSTLVKRehwA8nr92w4HEoFEkbACDSifkMc99hb/pdw60x/thf6Cil/4aB
         Tu+HgbL0gB7gwzw7gnyznMhlOuTrmedrM6GcDfLzjxcP6rEQRXmDzt5+fnp7wV+smImg
         0bLkEr0eXa5ZyWwFcJhaAltdq/+qhBZS7xEQqbIjm36M2d8OsBtSmpkD5zLBK9KHwpZ1
         SQQEnSnz1zTgRxOtTBAlCT8MEXp/JFftPzcwHIzZxaieHeRI59IU0Vfs3PVOoAXFQ8pf
         Uk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781214336; x=1781819136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykQKgx44w3X2k/qU7oxMtTqbK/zBreaZPe3qMH5/aXg=;
        b=CgiT3pMdWNzNpsThj7CJsoU00i60Vf9JNtzYAkQ9nnCPjkPXWvzdT8A0r1GTjxgf8l
         v+lJNioFPxd6mkZnZmxn7Hyryq8gGj6vlA7Qh1th0bdXe5B+SyxQw++4O++gcJXuhauw
         LNt9LUbesTEXxVxy4I+ZgHfRuAIMUAq6QubCWke3eX1ZcUfotIuyhkKx+7Z0qvNRpQCB
         ZrZQil9gvNoXBTyvF4K+lHBNWpJXeul4GUJ7D0YjtJSxCEZx0uuHWQ8c38h2OQkVVIKZ
         2N1egw9iS3EIb0YzbOe8c0mpEjdLIAeTPWsy5eHFn7VRUc0hG9pDdfTY5RD+KcCo71t5
         qNEA==
X-Gm-Message-State: AOJu0Yw+lZq+Dnn2n9+THZp+dEDO6r5t/HZH28hZMrTMCI7DFgyyjc9M
	Y4KsRyNV5FPT704xttFsmdZNo3gAJa5iTSv67EuRMV8oloL4TaP6qNpv9YLOE1tzEQg=
X-Gm-Gg: Acq92OFviwBGNuwzbUbXfpV/dbzh9AbApFmep6dhzthrTr4KOadyv5bl1cym1FeOG0H
	PyJqabIXHr7Ff5w6eQllrvMAh70XX7lpaT7GyumySsB+ecuVYUwu+xOS/9/eJ+n0K4Yf72d9GnM
	Dq2mesSfqJqDfaRAAe4g8aSBLEVm3OJeFhHUngo0QVa1fTqNCe01cr6ow/pI17ej6EmnyHwIbvf
	+KcnP1x86oQmQfVltRFvlWX2hGMmo2NwFNsqn4r1KlWh8FXPUMq53DrUE8AKEUK/W4hoJqGfDN3
	fpM4ITNViP5tvDHTUUEzu5LmFon21Q6F5/lLbuwggMTgTTG8SRtMla9eTyrr/muEE7ra/olKDGn
	As36Eu4dA4+4WJ/wEb99hwlYu1q4MW6XosSTMsdtfzoVGnh7uSUiuhAluH936RTKwVYebVgiAVP
	eTFVQ4HLZ5OoeCemwY6/0CCq1uh9DboQn2bjiNDjJ5Pf7HR9C9UZ38gQ==
X-Received: by 2002:a05:7300:641b:b0:303:f295:4db2 with SMTP id 5a478bee46e88-3081fcc3778mr100907eec.0.1781214335754;
        Thu, 11 Jun 2026 14:45:35 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8d3c9sm464289eec.26.2026.06.11.14.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:45:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:45:34 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Zhang Cen <rollkingzzc@gmail.com>,
	stable@vger.kernel.org, Han Guidong <2045gemini@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 4/7] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <aissftWzD7cdgz8y@pop-os.localdomain>
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-5-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611123538.156005-5-jiayuan.chen@linux.dev>

On Thu, Jun 11, 2026 at 08:34:12PM +0800, Jiayuan Chen wrote:
> @@ -2794,6 +2835,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  {
>  	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
>  	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
> +	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;

Reverse xmas tree style is preferred by netdev, see 
Documentation/process/maintainer-netdev.rst

 
>  BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
> @@ -3027,8 +3098,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
>  	 */
>  	if (start != offset) {
>  		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
> +		u32 sge_idx = i;
>  		int a = start - offset;
>  		int b = sge->length - pop - a;
> +		bool sge_copy = sk_msg_elem_is_copy(msg, sge_idx);

Ditto


Thanks,
Cong
