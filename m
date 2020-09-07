Return-Path: <SRS0=5Irp=CQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D6DC433E2
	for <bpf@archiver.kernel.org>; Mon,  7 Sep 2020 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CE321532
	for <bpf@archiver.kernel.org>; Mon,  7 Sep 2020 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599507165;
	bh=g+Xuhro+2C6jeU2SaqGnGSXANVvt/STb+HmWaf8GMs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tNzR4TdmSv95y30s/CglUSwuvBBibMwBNsmSmdG32sNwx9XFLR4LDBZX0rfJv3GZY
	 tuFWF2cvW0pPcNLta/G6+UWFjOwVrs9W9wfzNd5AOoqjH6DFHq6tGWPutIMT7IkW+/
	 r6MoEl3VsbbxcHJyqiIgFqhHvJTnJFlwLI40+nas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgIGTcp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Sep 2020 15:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbgIGTco (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 15:32:44 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC0F2145D;
        Mon,  7 Sep 2020 19:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599507163;
        bh=g+Xuhro+2C6jeU2SaqGnGSXANVvt/STb+HmWaf8GMs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jvc/WVyWVVkX7Oiqij0df2r4OmV818Ugg4hnSBDCuc8GFrUI3KBa+kmd5mx8BBpJ6
         BdCi37GOMcMFPqs0qoRGCAwzsyqmk9ygp8hkNwCrv+/tuasMRYFZbQ4XjL/lq1sT4o
         jXlGN+P8IZTp7SsinI/CXaow4DcFO52544ijn1QY=
Date:   Mon, 7 Sep 2020 12:32:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH bpf-next 4/4] ixgbe, xsk: use XSK_NAPI_WEIGHT as NAPI
 poll budget
Message-ID: <20200907123241.447371e8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200907150217.30888-5-bjorn.topel@gmail.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
        <20200907150217.30888-5-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon,  7 Sep 2020 17:02:17 +0200 Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>=20
> Start using XSK_NAPI_WEIGHT as NAPI poll budget for the AF_XDP Rx
> zero-copy path.
>=20
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/e=
thernet/intel/ixgbe/ixgbe_xsk.c
> index 3771857cf887..f32c1ba0d237 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -239,7 +239,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_ve=
ctor,
>  	bool failure =3D false;
>  	struct sk_buff *skb;
> =20
> -	while (likely(total_rx_packets < budget)) {
> +	while (likely(total_rx_packets < XSK_NAPI_WEIGHT)) {

I was thinking that we'd multiply 'budget' here, not replace it with a
constant. Looks like ixgbe dutifully passes 'per_ring_budget' into the
clean_rx functions, not a complete NAPI budget.

>  		union ixgbe_adv_rx_desc *rx_desc;
>  		struct ixgbe_rx_buffer *bi;
>  		unsigned int size;

