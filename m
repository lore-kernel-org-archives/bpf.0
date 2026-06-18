Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954C28469F
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758683; cv=none; b=AmUGdUqezb1g1yVP4EPJodgjjKgPxyOk0aI/wyYKg0SU5U0YKEoaeIPhZXaEiKNit4CQLprIzkTx6itbxBXrkYQ2QvjnArLkkkxf+NBk/hWmghB3TpvZOgDZuthRYfLc1AXO4NCJyzw2CdEl01kPk7o+nTOc9Z+2tm8Rm5JBQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758683; c=relaxed/simple;
	bh=fcJZVCd4rqqpaz+9ULGeGk3h6Fv1G6tv/WpF+yZ45bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCcuRuXUipXFaal5pcT7LUUwblv7wB/fwUBiSqkxpbLPRV51PiXqLMvNWyaQ1qDvF15Nhb0S3af9lCXMExcx8TsoreTF4sV2EZVLOWPThg+GVrx/+1NvIQozrNAwUe3LZ+VTQOTazg1fFLLNLvvzlAlAxdsW/mZzAi38bdQfbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCfoL2Sh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCfoL2Sh"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso313533a91.2
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 21:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781758682; x=1782363482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHSvIRDQemxGadgD2iE0xf18mNVbs+dB/ONQrSSSMCo=;
        b=YCfoL2ShWv1p5M+pPW+asVskRor0flxkuxSGvacHoGCC022JmxnFgyoVKeIOkMMCvu
         7PTBPswCfCx6k17fm2hUkAbeTpY6HPPPXO9O6mLqrxdFOfQS+7PvxyTP/Nr/yqq05CKc
         /tCtCXguKXDRrL10U46qkpMUgNIQqdLbxdKaY+xzDfm7p7OKhc7akAe89vKbHvLCjWqS
         Wx8GzBe0Bedvksd7Slf9Nq0G6cG6sGE1U2z8kWu7yX/R9M604AwKtirEOEupWsDpMKqk
         lBQCrILbhS/oPLdcyWTcJJQ6xVoKZoME9SUoCQaVxCayDDmzrmMbP6Up0+/OpFgSSXtZ
         04Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781758682; x=1782363482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHSvIRDQemxGadgD2iE0xf18mNVbs+dB/ONQrSSSMCo=;
        b=Du4GWwOh58F+PblL5pjDenjzG1GKE1AXCw4N+b79e0xrTOWBe4Tm7559G2bmnCH1sN
         p6PRLCbLTz89BdM4w4btK9h/GEZX98RqYTc+lKhQrU7Qie36goatFPh7XlsPedbATIHc
         mV5Cxe3n2X+bom24GdFCdLmdaaDWMtx7mEQX7Q+o6wPG4OsXUAsNfHqzctSZAg5DXx/e
         3s80DE4hC7gGEoKDjplvPKWm3tEWsZAoOvR8WegY8yshwQKiqgjojpAVTmGIoSGjC8Xw
         EbPdSJgTwKkWn4V6BfQWhYSc/YIf0NjN+ALdAfINA0WOE60SB6lC9yAGWbzYFhUVFJNN
         39AQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VyKpUEL2ZKguHzowSXIHdaZqrdwEof6Qy0h3qsTKYKx/ep9f93rNYa6OQqgHXM6OCajg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhczPlqXXyatEHXc3zOvc4IElP0ILziZagqg7UW8hHwOUO7lEE
	bQBhLMdZi5GFE4X1LrPvi7e6dvPUnSG0pfFH4dmus5/sdyeMaTgw/8cHPhjs8g==
X-Gm-Gg: AfdE7cme+eyrmmelIaj3YMMH9BgqyFyXuD2lEC0HOSTcS8v3vnp4UryQ66lyAuFMGcn
	8piQWRrYla7NjJpj4XGWix8ZoqeRS8de1SQXeML6z1ee2HxcTUM60Swe9SyXud39sWe9/eAv7LH
	YeYUZe8zpAhnNqldABMtgyBT89ElwOxZaMaQAeIAnhIoF1p28OvW0VZe8WvRkv6QSjr1yYr52Oo
	t9GLjt0Sg5P7aknED3v1NFvPV5NXpRuhkQW5qNWWBmR8Z+WJXWDL/4DYuc0lku6RXnwLP5i0MVc
	06Df0dt2g954kGtWKXANeLAjFMr1LUBumouWH5UiX5CDi1sxYmrowfCzX6vuajmmbg9amcMiHiy
	UU/ZA7fGeL0rYo8mDSV19ja5fReFzcyUalRzbcYzTnQbXeviXFH6bhqalLcsJCX5/SdC+H0BEpd
	PYaPw4nMQg9i03IjWpWasoHnNnRgOfmNHzwv/pNRt90Eigw5lr
X-Received: by 2002:a17:90b:5807:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-37ce4545be5mr1884346a91.15.1781758681588;
        Wed, 17 Jun 2026 21:58:01 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ca980sm7976715a91.6.2026.06.17.21.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 21:58:01 -0700 (PDT)
Date: Thu, 18 Jun 2026 04:57:54 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bobbyeshleman@gmail.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Message-ID: <kktndchjc5mnxcc4p3urfwu3sbkkpfvqo44st7z5djzntixvr7@2vnocsbraee5>
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
 <20260618002559.1479884-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260618002559.1479884-1-kuniyu@google.com>

On Thu, Jun 18, 2026 at 12:25:57AM +0000, Kuniyuki Iwashima wrote:
>From: Sechang Lim <rhkrqnwk98@gmail.com>
>Date: Fri, 12 Jun 2026 12:35:51 +0000
>> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
>> to find the length of the next message. strparser assembles a message out
>> of several received skbs by chaining them onto the head's frag_list and
>> recording where to append the next one in strp->skb_nextp:
>>
>> 	*strp->skb_nextp = skb;
>> 	strp->skb_nextp = &skb->next;
>>
>> and then calls the parser on the head:
>>
>> 	len = (*strp->cb.parse_msg)(strp, head);
>>
>> The parser is only meant to inspect the skb, but the program may call
>> bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
>> bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
>
>It's bpf prog's responsibility not to abuse them.
>
>Even setting aside that, why not simply block such BPF prog ?
>
>It cannot be done at load time, but doable at attach time.
>
>>

Thanks, this is cleaner than cloning. Will fix in v3.

Best,
Sechang
