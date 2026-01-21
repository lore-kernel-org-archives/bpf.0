Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E321767A
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960677; cv=none; b=K8eEZTsi2SZ6E3BgbJHYTFaukGe82BhvB0uqP87UN5H6IUlQmM+IM79h9j9F+7Kd5fj6a+pTSF095UzxKnql2aYDtr6j5QU8eFgjBtkLULvgpaI9OQOVke4UoZUPzcjR9mIFiQ+V1q6J8BmADxYzh5PDM98Auo/MkFmhxZAK0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960677; c=relaxed/simple;
	bh=Pxl8sMs6RnaZ020SHVaxZGQaaNcg2Z3EVnSdYyrD6HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xm5mmpVc6nNGR0Ob3Wijx0YBjxGYoHxHH4yu179dqPR+zNqYAoQa2BEIz6AgrAbWb9dL63OorL3akZBzpwNNRW14DvyuIcb53WKSnYhQqsqrZHwCMHJXX2V/3fjCNO9GVDs6AkzaHMExpctUvWUnL/Uq9IEBXJDkNxEUpAHHd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=folMGCSg; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="folMGCSg"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f1fb91996so13676289c88.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768960672; x=1769565472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQpr8TPg4r3Vyfobt5ZfLaeRlSoR7RFvm2Ik+WOu2+o=;
        b=folMGCSgV5ZiNC3b/56fs6/wa6nzZKaa8bGRiL/puyTMxWiOfX9AEFGoOQfHXnthae
         sMhq9rMkisErluwk0t3M3ct/f37pQwoFXCr79piQZeK4K6F6nweWjvkfeAX7DaY8LNb2
         EmvllODTlFRPgT1bRaVahVqgbmAea/+hguDEPm321R1Qj7zlsRZhk3/XTPgWKdrSU3YI
         eKpXImLTpjjEIl56OXLgViddHgN97aoshQH+vHZDy3NjE7K02us6dZ8Oh0g1eykjIh2a
         PR609OQjsEGVG3Qh5S/MzE7B1HtptBj6cL+RL+L+ClnpbK5JiHQ3RlEGepQUvliKe1//
         AbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768960672; x=1769565472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQpr8TPg4r3Vyfobt5ZfLaeRlSoR7RFvm2Ik+WOu2+o=;
        b=rMaKCFL1V+lFIExbG35MPPblPy05CxsF/LnBABCRdwCRLsSnegbAvFMefbUT+y2rac
         Zdz2q9+UbvYEjsuTlzJbSgB6BkyNUU5RIyC4ZdqXwqO2WWl4+AKZnxYPE704Dvm5m95V
         B/8zT460ijPwxhrAfgtZMWQMszlAMVhFk1z1Lp37rGvSCZdB63b57zls3wCDOJcpHJLD
         rvFEWfQc74qTlVU1nnqPZcLa0AlV+NfiwEgXUocFiRPbQ93hr2SwxZPCEsrjPnC30A2i
         ZMgp3Hu8uj71r4gxvRVBtlyxq627p2it65Azm31tZhgzKvNl+D9SVa3IrVt+7pcUkI+t
         6VJw==
X-Forwarded-Encrypted: i=1; AJvYcCXvui3nsUibwZMeICLa5w45Gq2R5I1bNfX9JykPSLakDt63qlAeyEaNns7yx+yZoTBoWbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BoGV4Bd6AVkfoBnmGrOh9pSzJUm3wZcUzmYy5JNnya4THIn9
	mUmt1cEnQYPIzK8UX3otoIbG47irpEg5GDrXnLSvwvF3Tfazsr/3oEQteptOIejoJ2w=
X-Gm-Gg: AZuq6aLjR64SAfjxDTE1laEw53v6d/wCFl9DD9zgdSwkPP6dWTSTTsNZBVMZbgw81ky
	g1iOHQeDLESicDTUmgcnDjuHbKVLiBMDG44G0wyaK0mgUv4NKiusMpirVoUreDUBu+MfEdjtqnd
	I8hYdRxjfWFE4Q+iR1qM471ApSYnzSXy2qZvtRNAWNNgjAiWD1gy8Wh4YVVfzTcdLLjwCG8a55r
	KlGAlLQc/vcb9777L97BYOqm6yle/ML1iQ4mlflO/+V8ELuZPyenzerL/MjM2ngTKf1zSMBBqwH
	5RST0t+OqtgjlBbG7wUm4zoOYuxDfR9dxrazcG6KNrnBLQr6rvaliuTHDEVy+gEpk99KPtaKPyE
	JzyxYPdVxkL+g4t4afCFzQPl0cMeSuK4AdOPd67XLt325EgftrVtojTU1ldS/U/eWyell41jIUE
	7X3zzN3C1bBze6SZ6z3kdW1qsGScRzGN1sVcE2ggRq4rvlzJC5nvn8pWaKof77/nk/3FeNlyPjM
	wmD7NnizlRg
X-Received: by 2002:a05:7022:7a7:b0:11b:9386:a3be with SMTP id a92af1059eb24-1244b3822femr12385044c88.41.1768960672335;
        Tue, 20 Jan 2026 17:57:52 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::3:eaee])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm23132514c88.7.2026.01.20.17.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 17:57:52 -0800 (PST)
Message-ID: <6040a96c-514d-45e5-8970-5c0f524d4a82@davidwei.uk>
Date: Tue, 20 Jan 2026 17:57:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-16-daniel@iogearbox.net>
 <20260120175115.12c9735f@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260120175115.12c9735f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-20 17:51, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 09:26:02 +0100 Daniel Borkmann wrote:
>> +    def _lease_queues(self):
>> +        channels = self.ethnl.channels_get({'header': {'dev-index': self.ifindex}})
>> +        channels = channels['combined-count']
>> +        if channels < 2:
>> +            raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
>> +
>> +        rings = self.ethnl.rings_get({'header': {'dev-index': self.ifindex}})
>> +        self._rx_rings = rings['rx']
>> +        self._hds_thresh = rings.get('hds-thresh', 0)
>> +        self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
>> +                            'tcp-data-split': 'enabled',
>> +                            'hds-thresh': 0,
>> +                            'rx': 64})
>> +        self.src_queue = channels - 1
>> +        bind_result = self.netdevnl.queue_create(
>> +            {
>> +                "ifindex": self.nk_guest_ifindex,
>> +                "type": "rx",
>> +                "lease": {
>> +                    "ifindex": self.ifindex,
>> +                    "queue": {"id": self.src_queue, "type": "rx"},
>> +                },
>> +            }
>> +        )
>> +        self.nk_queue = bind_result['id']
>> +        self._leased = True
> 
> No frameworks, please, this belongs in the test itself.

The timing of this is challenging. It has to be done after creating the
netns/netkit, but before moving one of the netkits into the netns.

I could make this a functor that a test caller passes in. Would you be
okay with that?
