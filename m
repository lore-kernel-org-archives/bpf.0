Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9E3E6DDB
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160111; cv=none; b=Jrw+/O4zNkiblFfTFmAhcta/d1uJ8UPEtnA9VET69quQ7hnhDgW4w1HdUuC+Fk1IdVCsDaZPju3YrWwQMLDROBQh4LC4gAJO6sbzYZas3zdefEQJyXdZZKoDXd/znzAw8d1+J2NHHl+XWgV0uovNHdJHkjeLWjIqyUv4pcJHqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160111; c=relaxed/simple;
	bh=AzN9iJ/2PC2bJY/nNv5V/vSdE5sX7BktLp2vGiXYbxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIA7OwhmHCIJXzw5E/6P4XmKhWv5ZeYTDS+bWg8B+UPMkm/i/YxeBumvj4oHWhr053X5Z6H/JnXtuGT9GH2y0/iosNhPy4ua+1jIEMzyRiRrEFvKQD0h6Bm92nYjByLTXVFwwdKphmu2TR0t4npA13bffyR1nn7LU8CAzBNWaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEN+jsJK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiiG5P0H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEN+jsJK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiiG5P0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778160109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA3uYduQ4Jm26gU9caKxlD3akBOvEc2T3FZacK7c4rY=;
	b=cEN+jsJKF8+8IFRI9k/622k3sNprZayEKQxZTi69REp0VsVe2N7GBeO4fpsyWJQB0ZwNNj
	6ZdWJ3YrFxFd5YAO1MPy2L0yIuzHKlh/yromTBGYIfMMOY8lt6RE432ZzKC9DYzRpE7+m5
	+fLMOnZso/SOhVR+QvMx5oCg4zkSJVU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-HkRVPoLhMiagg079hIAlXA-1; Thu, 07 May 2026 09:21:47 -0400
X-MC-Unique: HkRVPoLhMiagg079hIAlXA-1
X-Mimecast-MFC-AGG-ID: HkRVPoLhMiagg079hIAlXA_1778160106
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a5952c635so8671285e9.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778160106; x=1778764906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NA3uYduQ4Jm26gU9caKxlD3akBOvEc2T3FZacK7c4rY=;
        b=IiiG5P0HdULlxQnCkMNzQd+zcpmCUqPwU4yiNtOiZt6vO4E1xAnr8j19ZVvwf9SOMg
         ejqGNyByZaOnQNXr4fRTvG8xglaxjFR8+rA/AoEz8zNOq5mCCtEcdctB8L0tviW9yP5o
         0gpgKXtFyJCUnb1ZbBdIGQM7GOVDO8OhtNzlH0NbIPpDQTbGoSYcnXDzgE91VYCuC/J2
         uZtZg0juB6wkbej9W8HYYhRy4MJUWmOUGzHeuYMtq+KyHMNaGpM9VY/p4iIM4lNkaPrN
         ePwpMbfnPCnvm/Uj2pcIPZZAItHvrtCVyBQthulRQyOx3DnVtSrrHLjfdXxq5c4sEnGL
         T+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160106; x=1778764906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NA3uYduQ4Jm26gU9caKxlD3akBOvEc2T3FZacK7c4rY=;
        b=GA9e6YVIVn36DkOPdMSfMj+QowFiFfAHoIBpCbGS3c0rKbqO5owkN5lCEU4I5HnqJ4
         rIULXq7KXHrYtjuO1Nr8vQ55zs3vRJtG/TNDgvRxGasRrBYiIURRrQBcFsN9iYEsYcq+
         DXHOeR/rzJwoDMN2TpmFJ+i9MVT2qxpzvUTOfkZw4HqEuS+jUJppPKh06LPR2stehYrU
         UadoZcuQeuI1BJEJm1alEXhD6GpYURK1LK4DQljSe98owWVQCHNdiUJ7dLGYBWrkh4Q7
         oq20H0P0xX9iEnfNC+M9qRBHWSbHH54HkIQuykd13JIUTxAal35cYjbD73UPGyCF38Vb
         F+xQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ei5JjG1RTP0r/+OlhyUjs3QLcVFzu4pCasX5CNKr2GS2iW2lkwg9++x6dkn8KV4M9ZqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPFBck4bs9/7JjoCA1kDRjFgPFJx9H0NuOl/5klZo+hMlGUpB
	5VLKbSkXibnHVZrvJLU6cgMTKYjJZSobpqPdGUQdsc/+5PKCT7pg/rZAVCbqzIN50AWzJOy8UA/
	TvIDQpLulfFva4K1BVrvRAoh/tJy+FSyrHF09q/VzFKgk+gwooNgaCg==
X-Gm-Gg: AeBDiesu/+dpuePpiOp2Y9ovxQXDZbXclTE30ux1Lp4PLm/OVgN4PRV2c3ekMYi2Prr
	4YvTS96is1Qxi5WMVfiaUpYzjC5wUdm5q+iDulzEHbhdaOgz2nYFBdvY20YOUhrhLM4kTzmX1N+
	0KwlRQ1OzvyA4ZnW6jfh8AjLOeFQ1LqozBKkhB2F56BJ/y4KT3kSaFlMbVi7rrzJlg+LKjjL7a3
	kKEShj0qjeXHxo3cS9NGc8Gkc0HKJrz6Fw9zOXnpuN/R+5Fq/FgOwm0XPM0MWslE8wmmrZYzoVb
	OPGBmuDnb1rNL9Da9tZ0dpNZ8JJm+srFIvExJnPWQGZ9RnKatkL30/GmkRan5eMBqCRxwdLYbJ9
	o4D3Rf0Oc5Tgaio4o3ZfbJJD4nZxQuG0gcosBFCgdqYYPlNfvvdX2YeskxJ5loU8X2CChH98Rne
	9c
X-Received: by 2002:a05:600c:15d1:b0:48d:112c:f582 with SMTP id 5b1f17b1804b1-48e51e1e415mr72915465e9.11.1778160105847;
        Thu, 07 May 2026 06:21:45 -0700 (PDT)
X-Received: by 2002:a05:600c:15d1:b0:48d:112c:f582 with SMTP id 5b1f17b1804b1-48e51e1e415mr72914835e9.11.1778160105311;
        Thu, 07 May 2026 06:21:45 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e59b74277sm82568905e9.3.2026.05.07.06.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 06:21:44 -0700 (PDT)
Message-ID: <4e9b5728-1a8b-466b-900a-935e5647a623@redhat.com>
Date: Thu, 7 May 2026 15:21:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Simon Schippers <simon@schippers-hamm.de>, hawk@kernel.org,
 netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/26 8:54 AM, Simon Schippers wrote:
>> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>  			}
>>  		} else {
>>  			/* ndo_start_xmit */
>> -			struct sk_buff *skb = ptr;
>> +			bool bql_charged = veth_ptr_is_bql(ptr);
>> +			struct sk_buff *skb = veth_ptr_to_skb(ptr);
>>  
>>  			stats->xdp_bytes += skb->len;
>> +			if (peer_txq && bql_charged)
>> +				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
> 
> In the discussion with Jonas [1], I left a comment explaining why I think
> this doesn’t work.
> 
> I still think first that adding an option to modify the hard-coded
> VETH_RING_SIZE is the way to go.
Isn't the veth_poll() (towards the end of the function) a more natural
place to issue completion events?

/P

