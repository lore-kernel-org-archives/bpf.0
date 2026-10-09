Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB549A3B2;
	Fri,  9 Oct 2026 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533529; cv=none; b=b+8Mon5CcR2yet07PnkseyiwgAz1YsB65+VfKi8fWhKYnMZo5uGwj3bpZQWjxGFNTy9LnUDtNZoMFcR8JmUovIl6nZO77ZIZHewk1orDhU4DRhWGn8JTmK2NcZVNIS+ltWZvRWiDabPmML5KMcDoss7QNlbKLk1u9FDu8XqqYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533529; c=relaxed/simple;
	bh=9g8GhdZqrwTiMSGNKzfywx75moPMbKQS90MLrl+VtqA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJwqYvXHc4tphlIniWuWEQkRNUPyc0fxRSINoHwn5f5ToB0ka+3USzYGXyJIUJn76ZKEbty6M65k8JlNQ9h7DxisgeoagENgojDJOpRGJE14sqPp+ODyT8C51u+MxbKOIFoJToBfSv+Avcjd77YQNAb/g8HU2SMzCnF4eg8GFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYac/eUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYac/eUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3F21F00893;
	Fri,  9 Oct 2026 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533522;
	bh=0a6MsoYSHngnmjsCvOCOyazhgfgr9Po4zO9TLxSeEt8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TYac/eUDn/lPLuBdNh8urWDjk42CI0todpoGH4zQpti77VN/FhOupMAC0dpN8szYX
	 LcslRhYOgSX9BaPo4+nuFu85VJsHVQR4ThqLTHLnEiKv4sN3mbz32JttJZPH+ROqLH
	 /3ECrAFJAGpsM8sNox9COcv+1flg/i7P906nA6jqATgGnWpOMInUSWTkK3WcTSQAt6
	 TGvx7VNVC6/QWEgkILWZrl9CpOYB5IF3JOAlntUTplGRxuxAx4NgYHUZve3rYq8iff
	 b7rxr3PE6gwSv252JZlWzMl5paeOq5xzVJId9761MdaG9sdeV4ln+Nqzl6sQbcs9dR
	 lJy6z3+YnuxyQ==
Subject: Re: [PATCH net-next 5/9] net: skbuff: don't BUG() on leftover length
 in skb_checksum() and friends
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaiyuanz@google.com,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 09 Oct 2026 08:12:01 +0000
Message-ID: <179153352121.434549.5341536281761448782@kernel.org>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-5-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-5-1b4434c5357c@toxicpanda.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The skb_to_sgvec() kernel-doc in net/core/skbuff.c still says it
  "Returns either the number of scatterlist items used, or -EMSGSIZE if…

--

net: skbuff: don't BUG() on leftover length in skb_checksum() and friends

skb_checksum(), skb_crc32c() and __skb_to_sgvec() used to BUG() when
they ran out of skb data before @len was used up. This patch changes
each of them to warn once and return an error instead. __skb_to_sgvec()
now returns -EINVAL, and the two checksum helpers return 0.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6cd7135e0dce2..4070e0c25f63e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -5333,7 +5335,8 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
>  		}
>  		start = end;
>  	}
> -	BUG_ON(len);
> +	if (WARN_ON_ONCE(len))
> +		return -EINVAL;

[Severity: Low]
Should the skb_to_sgvec() kernel-doc be updated to match this new return
value? It still lists -EMSGSIZE as the only error:

net/core/skbuff.c:
 *	Fill the specified scatter-gather list with mappings/pointers into a
 *	region of the buffer space attached to a socket buffer. Returns either
 *	the number of scatterlist items used, or -EMSGSIZE if the contents
 *	could not fit.
 */
int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
{
	int nsg = __skb_to_sgvec(skb, sg, offset, len, 0);

	if (nsg <= 0)
		return nsg;

This -EINVAL is also passed up through the frag_list recursion by
"if (unlikely(ret < 0)) return ret;". skb_to_sgvec() and
skb_to_sgvec_nomark() then return it to their callers unchanged.

All in-tree callers check for any negative return, so nothing breaks
today. However, a caller written to the documented contract that only
checks for -EMSGSIZE would miss the new error.

The comment is still unchanged at the end of the series.

>  	return elt;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c%40toxicpanda.com
