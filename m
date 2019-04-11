Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7243C10F11
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 03:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61682133D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 03:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="j4PbWG9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDKDNR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:13:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41048 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfDKDNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 23:13:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id o129so2598204qke.8
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 20:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/YEEa7TET5vphgSbGlr4PUnj23dJzPK+9Di7VW+9W70=;
        b=j4PbWG9NCg+wZyVLjyxwXhHj09YAHGhm5PM6OidzjQ4Xvox7lphxhRZWkz0paVKQxY
         AO7BPoxZchD5Rqlhp3tTbLLJaH0v87/gubTD2TG3kd11jpTSIL21kAVSm4QEoWG0FnJY
         7Na+eEae7egm5O0Gs1MVczNMofmeHhUcgN1mgFs0oG4yvGZi7RXx0q9WFS3hkWO0tL7K
         PIBbI7dfBRFs3oRN5qqZXa35zlEZs7m6vjupW0m68ciexJjOiXzLrHc6+PbLQNGaNR3l
         5lc6TU8ZTmKtjODVlg9fHbnMfGdmU8HJ4OGnri5Vu693i4R9UtV5eKsI7EpXVleszVfV
         Agfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/YEEa7TET5vphgSbGlr4PUnj23dJzPK+9Di7VW+9W70=;
        b=C9IT9DWMxULcZDjll8hbEB3XATvZhgZYs6tE73rHm2npmkSK+fpSRub/hQeCjWEq7P
         iAIKmpS8Z2dr0rYnnoxMl9pDgTBwbWvB0tc1DnvNBhFefeNRmdJGLSerQbdOSugoVYoa
         +G4HEYuZODHxN/b/QWkZnezWm33n8WmmAxx92WxXtELcO38EKYV7iQv3frZedIC9FJmR
         UyniJRISRU65MboOg/h1E4aVfaJIugDrxCONzXrHnzZXYsUvSqTV6d1BNRz06jqPYTlM
         JU9+OkV8a6sQaQYKmAb6raEz6e1oDGjoAFPhno9cg+kP/dJZEDf/2vDsAou/BnZlViKK
         fKqg==
X-Gm-Message-State: APjAAAXo2tEbnURDtu9psH7mtR+kJOSPJ5iTocRlEbbur44WgaqRUXzl
        bTZWifxhqx06AsGugLgmQ1tTKgv91sU=
X-Google-Smtp-Source: APXvYqwTpE+0yGmPUJcI7YY8QE48R8x9FTnciMKGCCRLbDaRJf/NcACxSTCW2MOwfKPuTg3qGOPm4A==
X-Received: by 2002:a37:e20e:: with SMTP id g14mr36499581qki.138.1554952396322;
        Wed, 10 Apr 2019 20:13:16 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r15sm25583749qtb.22.2019.04.10.20.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 20:13:16 -0700 (PDT)
Date:   Wed, 10 Apr 2019 20:13:12 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC v2 bpf-next 06/19] bpf: mark lo32 writes that should
 be zero extended into hi32
Message-ID: <20190410201302.4e67d48f@cakuba.netronome.com>
In-Reply-To: <1554925833-7333-7-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
        <1554925833-7333-7-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 20:50:20 +0100, Jiong Wang wrote:
> @@ -2169,6 +2188,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  						    value_regno);
>  				if (reg_type_may_be_null(reg_type))
>  					regs[value_regno].id = ++env->id_gen;
> +				/* A load of ctx field could have different
> +				 * actual load size with the one encoded in the
> +				 * insn. When the dst is PTR, it is for sure not
> +				 * a sub-register.
> +				 */
> +				regs[value_regno].subreg_def = DEF_NOT_SUBREG;

Can't the rewrite generate a 32bit load?  E.g. reading skb->len will be
LDX | W, we still gotta clear the top bits in that case, no?

I can't find the explanation of this case with a quick scan of the code
and cover letter..

>  			}
>  			regs[value_regno].type = reg_type;
>  		}

