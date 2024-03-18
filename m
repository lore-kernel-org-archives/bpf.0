Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CA2381B1
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764371; cv=none; b=DQNrx+3+0z0pI/o221TcuksyVIGWXDrjDExyI0L3Tf/Khdg2DfY4HAZ4VmRPzcac6MMHQEmIyIFNblThxmbdIzOytaMxoHz/AllGRP3JdIX28MCvSzApWMJhv59Gjx5zCFUfD48o6jdFfLQfIqVdMp8rMNahP+43KeeTEZYOPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764371; c=relaxed/simple;
	bh=pOSlkUulYyw5/O4A+X0uYoH/0HZhuQNeAcLk38o/IBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAdQsDSm0VVPLTszzP7SGDXpOhTB0AQ31OSXUHchb2/wN88cdGb0SOSCrqm5n4WnGRsF/qUDkTOY7PQSE9kWjPsrIxTIG56hdmiDZVOjj8RUzAYn1TnaoDk+pSprBYyLvNd26aukMJsUyW7tc2uj7XShi8xInEv7qYQkU+65sBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aaEwdND6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aaEwdND6"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-568d323e7fbso1396475a12.3
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710764367; x=1711369167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOSlkUulYyw5/O4A+X0uYoH/0HZhuQNeAcLk38o/IBk=;
        b=aaEwdND64LiE8FYe7nBzBYvjKQD99tn2uikFgpMIZQWr98se8EsGqjiE8aO8+0BLEg
         Td+mrf2BtIDFn9LNNiRyBh3ZdW6NmnhWqBaKslesdVEzpl+PagC0Pb6DR669E4tnjad7
         o2a9OBHRJ/hFmqXYZmCy8b/kxZcrhWjDCNj3REai7vuWjl8G883ZuYWM9iu4WYp1oGNo
         ne3lehklZNdfGovA5oKmJfQyfnYkcly/487nl5DyD3Mu4xV0J15o/GsgcsMlBSplkS3N
         OSaCf68K14QyFZvweJO3p6ps8DhDAHhB4OrjBsIrsU3POxEuMzaZjUMY6tiCk/o75ixT
         WyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710764367; x=1711369167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOSlkUulYyw5/O4A+X0uYoH/0HZhuQNeAcLk38o/IBk=;
        b=srdBKnMBoPi3EAkumiTIw4LYklWC5pPKRctbRl2i4NyZa3MmEuxqG8Hx/+yGv8bZ3G
         Hj3vhDBUOSQU5CXbY64tqiqPGswuW9lxHC+wJ2unCUAa5T9jgbGjI4f/Pa2spfUu8ExG
         YXqs/d0jY6x6quZLicT/MFXL74L3ei1j+NrF9owI+XkhAMddvCDrp8S27OCq6EBVqL7x
         CxuNRvLb1OvR/oRjBstP6J7/lJRzAZjhcOFTOQ16CYBvwWM47cLJwIs1ncuGlZDtGVgD
         HDHDXypGtze29mPS2BKZ4gzWAXpVMq6GK90ky5JUIeHA/XjNNpuBVPRgOJOxl/VVXFnS
         zDcA==
X-Forwarded-Encrypted: i=1; AJvYcCUKfBkGipVfRR4aI9Yo7i3SsCYGlpENn+EIsds4gWqxDhxmF+9hmJgguRuycCD4oDiPdqn/B07kI8iKjKT/egSvzlGJ
X-Gm-Message-State: AOJu0YzPofbmCVacfari3lPUldc0nqUkWxxJWAtx5PeKOvU1QFfQXu3G
	5UD2gTOduko01mFwD7KCFds/a7UomlK0iUi4uvxM/XUwdiyguYwuC6AY5ivqHJ8=
X-Google-Smtp-Source: AGHT+IHF1tEj7gb/YwVHDW9BOuby74iZuApmYgSUxT3zLZ2JgfbTwLMWpYsP7y0MGCfo/Ko64/Zs/w==
X-Received: by 2002:a05:6402:c13:b0:568:b391:4ec8 with SMTP id co19-20020a0564020c1300b00568b3914ec8mr5028130edb.12.1710764366639;
        Mon, 18 Mar 2024 05:19:26 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h13-20020a0564020e0d00b00568b163c4easm3421073edh.11.2024.03.18.05.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:19:25 -0700 (PDT)
Date: Mon, 18 Mar 2024 13:19:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <ZfgxSug4sekWGyNd@nanopsycho>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
 <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>

Mon, Mar 18, 2024 at 12:53:38PM CET, xuanzhuo@linux.alibaba.com wrote:
>On Mon, 18 Mar 2024 12:52:18 +0100, Jiri Pirko <jiri@resnulli.us> wrote:
>> Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
>> >As the spec:
>> >
>> >https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>> >
>> >The virtio net supports to get device stats.
>> >
>> >Please review.
>>
>> net-next is closed. Please resubmit next week.
>
>
>For review.

RFC, or wait.

>
>Thanks.
