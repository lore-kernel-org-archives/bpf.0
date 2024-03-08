Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE31E863
	for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096069; cv=none; b=UI3PHwNPg5aqxu9P+3a8huZEblqR9zfHUxKAVQt9Rj3kP6TfgFwBmVKJhjQoTO2/q0FiuCQ1ubqqGMx+csRbXa8xTAVZMF4aelmjDY7B1n1Xwfv1I6G4JX5XkjVS8W74lrErrIc7cdgt0dtjEtQ9SMRN0eTg/yuPGMdKsepKXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096069; c=relaxed/simple;
	bh=AvFQPp4kyLh+TFglZjeC3Lb5VBfSdzOtKtFyl1V2cFo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=caqbNhZbZWBVEioAGMrlVtHaL/1t01uTt4yiRs4MGqg8XaIAK51oQX1su5oeyGXxCxb29oKK9ZEjaUGmzKtCwlOcEOH23hnATaemdjlnKibhnfVpwjoVp+tl/E30JYsBgqcqyXhDU4A5N0+AKR+0Nhk2ZOICR2J/JP8CJsBTHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GS3FxPxX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GS3FxPxX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a461e09ddddso52499266b.2
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710096066; x=1710700866; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=tL0MzOZMsAFV4TRaP2fV8WC40d9wfVEKBIBOf/OGnHA=;
        b=GS3FxPxXRc2YsizCg9zFziyMUzGCdKKSYYZFGbcW3iTbR/cqxheBj08fQ5xKyw2cVj
         iz/JPv2ckcgbFJejQiwYWrMTCEMo22D1oTUI59d8/DM6RVTI/wH8g/YyLWlqM8U9d7lF
         zlJYfcwTVu4EN0IXOIALQjS8ZmZ/JBARdDsNPkCfu5+RN3xhjDpTnlO8iCrQnoFB1dYG
         Pc2pEPIUZGyR3jRhvTFsY0uKMD/KSueRgyZ4OSLnfVU2+C6NATB6otdGmX/MSuXufSEo
         mJwikh3oamxxwmxwDTmDmu0k2KnsffjPkCYXwaynr8eTMYoe+x2gAxlwhl4TxMG0ncqN
         mKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096066; x=1710700866;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL0MzOZMsAFV4TRaP2fV8WC40d9wfVEKBIBOf/OGnHA=;
        b=nuGG/RtMN5Crvfo+4qxpIDoBhGS+P2gJGMDsMsiEeXBowwJysKAN+fsy2iDcxgz6xi
         qExgKxsXpQgllJTcaljpFJYgy/ZzI2hZN3gYveEoP8jpbrQx6yAeiavhvb5+jgJLI6X7
         LaiUfMH0nxu8K5C6BQdLLAminTdIFU708W1Xame9dJ+1YPNd3u2hU4opvKD/KpOlJnDw
         kzTmaqiLiasGw6wBoBA63Nhgf/2Cx2TJeyyZT1mdh8Ww1oZlirdgoJylP5kaDJYF9iOH
         AZkCCb5pEDfYvRkhjQlGXgWAX5hr/y9qxZgxxlResGdps730iWwfQSVfzAgAonJYUz/A
         IHmA==
X-Gm-Message-State: AOJu0Yx5Vwu5S49FHtwkSS9NiJ1fuIGgPVuprBhfLpArEXguJhYZ7AXt
	mZhXQjdFlGShDfMAKYTcbEbfTfvzaAAVCIjBRxDrrSjbP/VYdRTbBgwGD4q+pks=
X-Google-Smtp-Source: AGHT+IFIjgRQ9mjpImT9qf2vtWWU2jZ/hV1jIr40gk6/mKtG1jBTEtkaBQmSxRu4E3z/u/Wqd6zKKQ==
X-Received: by 2002:a17:907:c310:b0:a46:1f6d:3052 with SMTP id tl16-20020a170907c31000b00a461f6d3052mr1735697ejc.14.1710096065817;
        Sun, 10 Mar 2024 11:41:05 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:8f])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906564200b00a4619ab82c8sm982105ejr.197.2024.03.10.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:41:05 -0700 (PDT)
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202216.3891808-1-yonghong.song@linux.dev>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, Martin KaFai Lau
 <martin.lau@kernel.org>
Subject: Re: [RFC PATCH bpf-next 4/5] bpftool: Add link dump support for
 BPF_LINK_TYPE_SK_MSG
Date: Fri, 08 Mar 2024 16:07:22 +0000
In-reply-to: <20240305202216.3891808-1-yonghong.song@linux.dev>
Message-ID: <87frwyrku7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 05, 2024 at 12:22 PM -08, Yonghong Song wrote:
> An example output looks like:
>   9: sk_msg  prog 108
>           map_id 84  attach_type sk_msg_verdict
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/bpf/bpftool/link.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index afde9d0c2ea1..5eb140197d3f 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -526,6 +526,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>  		show_link_ifindex_json(info->netkit.ifindex, json_wtr);
>  		show_link_attach_type_json(info->netkit.attach_type, json_wtr);
>  		break;
> +	case BPF_LINK_TYPE_SK_MSG:
> +		jsonw_uint_field(json_wtr, "map_id", info->skmsg.map_id);
> +		show_link_attach_type_json(info->skmsg.attach_type, json_wtr);

Compiler says - missing break.

>  	case BPF_LINK_TYPE_XDP:
>  		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
>  		break;
> @@ -915,6 +918,11 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  		show_link_ifindex_plain(info->netkit.ifindex);
>  		show_link_attach_type_plain(info->netkit.attach_type);
>  		break;
> +	case BPF_LINK_TYPE_SK_MSG:
> +		printf("\n\t");
> +		printf("map_id %u  ", info->skmsg.map_id);
> +		show_link_attach_type_plain(info->skmsg.attach_type);
> +		break;
>  	case BPF_LINK_TYPE_XDP:
>  		printf("\n\t");
>  		show_link_ifindex_plain(info->xdp.ifindex);

