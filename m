Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F2FC2BBCD
	for <bpf@archiver.kernel.org>; Wed, 16 Dec 2020 19:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6E206CB
	for <bpf@archiver.kernel.org>; Wed, 16 Dec 2020 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388781AbgLPTdG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388769AbgLPTdE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 14:33:04 -0500
Date:   Wed, 16 Dec 2020 10:55:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608144916;
        bh=D3YhoTgf40AlLt+GK+vtGN+dciBHeYG4J/pl0zPj0AM=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=N08LpIyjKM7c3XZosA7JCe6ugqra2HgKjjz/JXsgHerl6m/7fwavEuRuwHG/LFqAv
         Ej12hXAOF48HsTwbxYivm7IYLsNXvMGmdV3GKA9gOE14xQseXrO3t3zPi25J+GFIcE
         n6vZ7Uwo9w8/gm0x6f6vae7JddFW2Flaw4hbANYuOs1wko4uzAKAXZWLfim1sZIuuC
         8OvXZEaGPqrfxjp4T+9E01jKdaztH7cneevYibxfCRGa0nSpA18Fn0pXUEqr1SIhEL
         833uezVgSgZToHvK2K94MlnlMRBh+E3p91ZFihNTPnG9YzoiCsOazLZDPYwrL3sbAd
         5tIKNwJ0QJhyw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     intel-wired-lan@lists.osuosl.org, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        maciej.fijalkowski@intel.com
Subject: Re: [PATCH net 0/2] i40e/ice AF_XDP ZC fixes
Message-ID: <20201216105514.3211bc60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201211145712.72957-1-bjorn.topel@gmail.com>
References: <20201211145712.72957-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 11 Dec 2020 15:57:10 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> This series address two crashes in the AF_XDP zero-copy mode for ice
> and i40e. More details in each individual the commit message.

Applied, queued. Thanks!
