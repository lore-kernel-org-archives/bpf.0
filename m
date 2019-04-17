Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776FDC10F14
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 02:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4238C2177B
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 02:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R21BU3Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfDQCX0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:23:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33075 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDQCX0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 22:23:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so17597160lfm.0;
        Tue, 16 Apr 2019 19:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrQAzZLpeZotC8N2rj+UjMPtfqEaeL6RgIWC90EfxsY=;
        b=R21BU3RoGkUE2+DcgJbU2ndEP62sID02AZ34DPRtp04NRtB3+DKfSZMkBbKJQpGkcM
         Q6IPXk+eoZwyxQkRsxieIZ687X0tfwbwtUzdR2wKJiqdxaGc3109dJqxYcXOISKo2Eu+
         O0GyBM5PE+tGqfhUy5EM7KxQ4ojImMY9oDndL4jAJQvszFsjfv6F3LjoswYET1QJVX1l
         dNfDXOpu+gH7bpN/eSghD99bveqwtW45X01RUBYJLgwallhb4LTEstsQdFujQ5vxuv0z
         ITRvAgJvhmHOt6lPG5i3Af8O4NLQMNrbCu2e+lb5y28XafV6w+vMBJF+7DHoQIYwRrKc
         cY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrQAzZLpeZotC8N2rj+UjMPtfqEaeL6RgIWC90EfxsY=;
        b=XQRs3URHOsb3H7J3CAYnqCMueFF9vHC1XZz2tB1P8jF2w8gcH5e5FG0eDlEPfW9L3x
         R2DLb8nSQ0UxSRknoAPFhhBF7lZ/xwUhj5AzgCj3OQbWqwLcICajKa1kMGdj38VXVpMf
         cwMHc4m8X9P9taFj2OTJfcGVG+mP6qu1MKM2yTZVdudWjIDQolLZz2QcWNapY6vlBST1
         TRurS2z9VoUPolD8q5wscXz4b3ji3jAte7qKOC6p0dAQr6dI1mP10T4Y1/CH4omOR+uG
         6cPo3+csXb2TKFRZnuVx9KVdeqoo3sSrDnS+mCdrS5JrQbT9exuTDuVFC5cZCAyHx53R
         MQZg==
X-Gm-Message-State: APjAAAWtJcJ/ERFidm81tUSiVMrDcODBm6MC+4Ipey6s2Ta5GPyTu/YV
        tHSRYnEeDQM6bm2R/xzGK8LT57YH3wet/czq7VA=
X-Google-Smtp-Source: APXvYqxkexHV93e4qehbS71IFwfn5TMrXDwPt9IsHLqd/lkr4FomYLlErjoIeGUMJW3YdwtAmtq8YHXK2UizIqfBvy0=
X-Received: by 2002:a19:ca02:: with SMTP id a2mr16605341lfg.88.1555467804444;
 Tue, 16 Apr 2019 19:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190403154338.29990-1-posk@google.com>
In-Reply-To: <20190403154338.29990-1-posk@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Apr 2019 19:23:12 -0700
Message-ID: <CAADnVQKxR2jhwPAEVGj9n6aHXfvfZvngdf=jDmyR_fO3SkUTfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     Peter Oskolkov <posk@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Ahern <dsahern@gmail.com>,
        Peter Oskolkov <posk@posk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 3, 2019 at 8:43 AM Peter Oskolkov <posk@google.com> wrote:
>
> This patch adds tests validating that VRF and BPF-LWT
> encap work together well, as requested by David Ahern.
>
> Signed-off-by: Peter Oskolkov <posk@google.com>

Applied. Thanks
