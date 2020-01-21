Return-Path: <SRS0=fGWk=3K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB7C2D0CE
	for <bpf@archiver.kernel.org>; Tue, 21 Jan 2020 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471DA24125
	for <bpf@archiver.kernel.org>; Tue, 21 Jan 2020 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZT+aumu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAUSip (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:38:45 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:32946 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUSio (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 13:38:44 -0500
Received: by mail-il1-f182.google.com with SMTP id v15so3196012iln.0;
        Tue, 21 Jan 2020 10:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HVvO29Byv8Rs3N5eik5r8E3uqbkruznhQBAZRbrG7pA=;
        b=LZT+aumuoKYJRI6kEZ1KE7Y2PQMf6ICj7AIuuGOS7Clb480/O3U4VBNhPZS8+cnVVm
         pUz2cDbp1OKb2CuItOlTPuLKgvrHTI9boENTTgHSUkMk9hIHMyDXcjpISOyTBtb0SOUv
         BtnWqpBH5c9Yo3yFg7PFoAXooVf9T6wqagmiR3ZGqf+cR0/g0LyXrFTB9Q7LgTjyPq+d
         SGhwmGAUQxM0rYeWNAnLilfKn0Cn+Zoo0p8cDND/t9iBCHhkNYiXRpFwWPKDOTXoOHh0
         hM/4dvgvBe23gpxizGoo+F55Vo3lJD+T99NkeVhAxRYYNMDqjk4GKhGo076mJSF95L0x
         SZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HVvO29Byv8Rs3N5eik5r8E3uqbkruznhQBAZRbrG7pA=;
        b=MH5GMDxGOMLN3nyvJAa4fw+eBjqC8PCZYsB6FlMSggq33cSJIkxk9H3r/aYV1aoeHe
         N/bDKHhDfaos3m7FRF7cSXQn5ydWp/vBL4U+g4tBWDjnwp53YNY8AqruuQbyXaSUFqd9
         yuPViALGFxSAr07t+dV/gIGE8UqNeAvzv9diC/hyyHbyzLfz0YAlb42LKPdlUr/PHR2M
         He/lfHhNaeoEKxIeMdgV8n2VXUHpnSS8thiQcHC76x2dIbr5h6kpuW+dERboNjQA5t1g
         7/LF+lBRPwYxAeAwYi/5TXU9XucTdNrQJDg1a5zhtwMw0j55XW7iTjjkckSPw751kcgV
         JBLA==
X-Gm-Message-State: APjAAAVmz455s73Wc0Yqc6jU2SlL4byn0HMXqEV4J/RM2cBezfQ3M4+1
        CzghgEwZhnpHJiCvWGxdOdM=
X-Google-Smtp-Source: APXvYqy3JXOHilA9MOfBrxvlfkynjTQlEL7IwLoqnYykgNFDtd5X0w2lsmTWWJDq3Zb9yRyE0FMMAA==
X-Received: by 2002:a92:84d1:: with SMTP id y78mr4849485ilk.69.1579631924042;
        Tue, 21 Jan 2020 10:38:44 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id t16sm13344368ilh.75.2020.01.21.10.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:38:43 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:38:34 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Message-ID: <5e27452af3157_74b42ad14ee465c075@john-XPS-13-9370.notmuch>
In-Reply-To: <20200121005348.2769920-3-ast@kernel.org>
References: <20200121005348.2769920-1-ast@kernel.org>
 <20200121005348.2769920-3-ast@kernel.org>
Subject: RE: [PATCH v2 bpf-next 2/3] libbpf: Add support for program
 extensions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> Add minimal support for program extensions. bpf_object_open_opts() needs to be
> called with attach_prog_fd = target_prog_fd and BPF program extension needs to
> have in .c file section definition like SEC("freplace/func_to_be_replaced").
> libbpf will search for "func_to_be_replaced" in the target_prog_fd's BTF and
> will pass it in attach_btf_id to the kernel. This approach works for tests, but
> more compex use case may need to request function name (and attach_btf_id that
> kernel sees) to be more dynamic. Such API will be added in future patches.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
