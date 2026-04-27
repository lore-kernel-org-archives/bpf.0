Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74826738D
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329624; cv=none; b=TTmnuVsSlhbo0pQTiiayELJaCC/Q0qyG4E+JDPo+62NS2n4shZTia1cbxvX6plx4IE/LQlvua048wVCHAu/Ozev9xebTUMi945C2qsyY9Q7M4x61j3WUXwaLZs5TxCrcMtf0YWIduBF76IY//Kyd+wzCYJPJ78ENHLJvOq9kWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329624; c=relaxed/simple;
	bh=d5GAfifer7UhwpqXfJzxG4VAbQdW+fQHcgwzYkW70Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDkcPvTNIrYbrN52GTddRg4TK1Ay7W9T18rkmTIQAWvkFhR4tu2xEKZcv/KhiZVA8qn3t7c81lBdrBauXo9JrkiSmKIg191T9z8z4ZeI2VE6EQz77VluQtGctm7IEG+1bIstxrO7kajh8Zf8ioIIAUcHY0aun9vTYfQDzPvcHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XJLizVjH; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XJLizVjH"
Date: Mon, 27 Apr 2026 15:40:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777329620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WzrZN74GVBZokC1ryglYdW2bR4JGJX0G4YAAV4itqnE=;
	b=XJLizVjHfNvoYMow1Gn+PESNu7GTFZH7JoiHLokhkU7NgzjoW4JfgkCkROS113iawSgOdc
	ScOEwT8TqT+nbYw5BviqAr6mlCrLzc9pExN5zvd9cXgh17qOnmbyO2gNZA79M10CW8CkUY
	Omj6sAtmd/uqwZgrobjziByoinoh4vk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Nick Hudson <nhudson@akamai.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Max Tottenham <mtottenh@akamai.com>, 
	Anna Glasgall <aglasgal@akamai.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] bpf: refactor masks for ADJ_ROOM flags and encap
 validation
Message-ID: <2026427223629.lOYH.martin.lau@linux.dev>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-3-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420104051.1528843-3-nhudson@akamai.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 20, 2026 at 11:40:47AM +0100, Nick Hudson wrote:
> @@ -3618,8 +3623,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  {
>  	int ret;
>  
> -	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
> -			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
> +	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
> +			       BPF_F_ADJ_ROOM_FIXED_GSO |
>  			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))

It has conflict with a recent change. Please rebase with bpf-next/net.

pw-bot: cr
