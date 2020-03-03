Return-Path: <SRS0=fWzt=4U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE8DC3F2C6
	for <bpf@archiver.kernel.org>; Tue,  3 Mar 2020 22:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2A52072A
	for <bpf@archiver.kernel.org>; Tue,  3 Mar 2020 22:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2DmQbOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCCWpZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:45:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43979 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCCWpZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:45:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id v22so4189252qtp.10;
        Tue, 03 Mar 2020 14:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KRYpfQvxA0g2SoZmyZxwe6OFdPqUr/LPLdrZmjK0Gas=;
        b=u2DmQbOVVWFnkDoUK/m6UVdK9PPO880OwQEJUXD4BNSO/+zKf9YAo6tF/ZWBRZ8T5o
         gOSUuAIQtwg+Tg0IFA8nbSs+eHXNCyG1ZixOohp+m4UJyEsAI2IgmHcJrAtY7y+z5/NQ
         WuyZFpUjz2gbewKVgeDIt5Y3eCE35PAQQEiJHV799hq34+B+wP+1YWmDO48eMVEniIy9
         QLD7GPHoEQFQc4z0pzoNV0mDtInQ2Y2wGnLLUcJ7TLccbA2V2DyYo/9kZU6t/Qm+mQAd
         mWD+NHlMboSh5Z551bbC4AgUOrPm21Ub6ityxfqo5o5ifGaxFouBPpXvGOGhgOOf3Dr3
         eL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRYpfQvxA0g2SoZmyZxwe6OFdPqUr/LPLdrZmjK0Gas=;
        b=NI4tDShbEXJyW9QXUIPiCqFRpGOe+HaCyFwLI5kV0l0sdc0ridgh4mmIcuKcvOiBJt
         RiMSd8o+ZeCfP0381OiGEqAwAkb8Zz8b74P429prwaG0ciMatszerUdoNwPWB/DbQVl8
         p6yoPe8DVLjyKDMo+l5btXtyTy1tkRhN+l31xUZF4DsBhJubKb/MQXv1aoW53UVYc8Op
         idJaYZtzzDNAlUYpEhnAV2ITyUY0m9H8MLQA4MVd4pNYRxkyPkmlTtP4F+UC2npn2hdm
         kFBs8LVdWzy102rk7pQXwU4wl9qnohr5+34edkMV7mce01gs96Q09yF1zYLw2e9KfTh2
         I7GA==
X-Gm-Message-State: ANhLgQ16nUflfyTAAn9DMUOwalDWrtiLFDrmvj/rIjgt127NyxjIqn+/
        YvVGAUgm+I+7tqblbulZ2lo/d06STSRexDCU6T0=
X-Google-Smtp-Source: ADFU+vu+cDp+jWP8nHfliswmb21LxeQcaE6rBc0VUpw3lRAKhOpQAEPIzxHngc270gZgDoP4Q6KdSQ1MeWlptLBvFsw=
X-Received: by 2002:ac8:4d4b:: with SMTP id x11mr6436947qtv.171.1583275523055;
 Tue, 03 Mar 2020 14:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org> <20200303140950.6355-6-kpsingh@chromium.org>
In-Reply-To: <20200303140950.6355-6-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 14:45:12 -0800
Message-ID: <CAEf4BzZZMjEAV-yxzmOG=EqqakodaN5QR1gMMKYHh7vQOZM2PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/libbpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f8c4042e5855..223be01dc466 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6288,6 +6288,10 @@ static const struct bpf_sec_def section_defs[] = {
>                 .expected_attach_type = BPF_TRACE_FENTRY,
>                 .is_attach_btf = true,
>                 .attach_fn = attach_trace),
> +       SEC_DEF("fmod_ret/", TRACING,
> +               .expected_attach_type = BPF_MODIFY_RETURN,
> +               .is_attach_btf = true,
> +               .attach_fn = attach_trace),
>         SEC_DEF("fexit/", TRACING,
>                 .expected_attach_type = BPF_TRACE_FEXIT,
>                 .is_attach_btf = true,
> --
> 2.20.1
>
