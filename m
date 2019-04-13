Return-Path: <SRS0=1cax=SP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA39BC10F0E
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 01:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F626218AF
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 01:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="anB3Ym7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDMBHj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:07:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33885 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfDMBHj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 21:07:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id n68so6806678qka.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EQhjEthcdsL8TrX/dt1298mOYBVO3BCIpw5NY5ET29c=;
        b=anB3Ym7sWl7JGHu7fskWRm11qHMqhZbxHa5mCLYVktLbM+hFa0usziq5VY5UduwWtM
         MyjVMXfjN0RlsXz4zg8mpEnnnA7FVJ7uoyA920CQ6Ds6/Z7tI/bCDEXQgV38VKxMYFPk
         MOnKkNMuzbFhm2k/S4GyE02WG7UuwTXr73FRXCMyZPQCrh76HfIfvOd5iWkvdJfENji9
         qCER2AMWApoqGbB/iCSCSeTfK3lfZmXfd/VK2dZl8YXkq8nsCSvoQMeqa6NfnGU5v6uz
         cAirG3Yptsq0aqxcK5Gdf2xLBW0DAZWesm0gATvSbjjsTserJFF2ecYkCZozRXxQ3zJV
         zqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EQhjEthcdsL8TrX/dt1298mOYBVO3BCIpw5NY5ET29c=;
        b=efYpD41ssb2fmG3rnq9ERl56SJqVpeOnHfquhAOukxR+AGS1EALO7Oxo/5rt6AV0+B
         1eV88Hhte7QFueN5tMixu/QTBIxxyjCz7l+/px6Bk5qdnWtivdPDxnqnNz06/CH9BNB6
         gSzrpiyDquSQVkyKS09tX3IaCPF1vNpdgcsWP59TiLp9hTyETnbRe+q8d182MhTdQqHi
         9khWnJtfKm0u4O2koYiFkjG2E/kPkTqmZVXi4VGKugxv/SThqHatzOubXQpScxHNU6Us
         7uxTriAfORUfmSK4aCWeKpnJ7pOfAvikrkCP92zm0eUgH3bDxczO0wwgGivZlrEzj39N
         60pA==
X-Gm-Message-State: APjAAAVN5wnRW7iUJ79k7VYtCKVWrWYlEYZ+8n4XcVid4syrgbufw6s1
        z9bUHDqCvv12cG7BJ7rSWG0TBw==
X-Google-Smtp-Source: APXvYqxm0kGw+8e1jJ8CzgNc86T+Itizqy6dFdv8XNt+z5bdK2h5io10c89Z7XxvLcxM/dg0CWv24Q==
X-Received: by 2002:a37:a557:: with SMTP id o84mr47982477qke.277.1555117658847;
        Fri, 12 Apr 2019 18:07:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h187sm25404261qkf.97.2019.04.12.18.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 18:07:38 -0700 (PDT)
Date:   Fri, 12 Apr 2019 18:07:34 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v3 bpf-next 05/19] bpf: split read liveness into
 REG_LIVE_READ64 and REG_LIVE_READ32
Message-ID: <20190412180734.2f863fbe@cakuba.netronome.com>
In-Reply-To: <1555106392-20117-6-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
        <1555106392-20117-6-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 12 Apr 2019 22:59:38 +0100, Jiong Wang wrote:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c722015..3c5ca00 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1135,7 +1135,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>   */
>  static int mark_reg_read(struct bpf_verifier_env *env,
>  			 const struct bpf_reg_state *state,
> -			 struct bpf_reg_state *parent)
> +			 struct bpf_reg_state *parent, u8 flags)
>  {
>  	bool writes = parent == state->parent; /* Observe write marks */
>  	int cnt = 0;
> @@ -1150,17 +1150,17 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>  				parent->var_off.value, parent->off);
>  			return -EFAULT;
>  		}
> -		if (parent->live & REG_LIVE_READ)
> +		if ((parent->live & REG_LIVE_READ) == flags)
>  			/* The parentage chain never changes and
> -			 * this parent was already marked as LIVE_READ.
> +			 * this parent was already marked with all read bits.

No big deal, but I though said you'd modify this patch here...

>  			 * There is no need to keep walking the chain again and
> -			 * keep re-marking all parents as LIVE_READ.
> +			 * keep re-marking all parents with reads bits in flags.
>  			 * This case happens when the same register is read
>  			 * multiple times without writes into it in-between.
>  			 */
>  			break;
>  		/* ... then we depend on parent's value */
> -		parent->live |= REG_LIVE_READ;
> +		parent->live |= flags;
>  		state = parent;
>  		parent = state->parent;
>  		writes = true;

> @@ -6227,12 +6317,19 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
>  				  struct bpf_reg_state *reg,
>  				  struct bpf_reg_state *parent_reg)
>  {
> +	u8 parent_bits = parent_reg->live & REG_LIVE_READ;
> +	u8 bits = reg->live & REG_LIVE_READ;
> +	u8 bits_diff = parent_bits ^ bits;
> +	u8 bits_prop = bits_diff & bits;
>  	int err;
>  
> -	if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
> +	/* "reg" and "parent_reg" has the same read bits, or the bit doesn't
> +	 * belong to "reg".
> +	 */
> +	if (!bits_diff || !bits_prop)
>  		return 0;

.. and here?
