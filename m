Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C6AC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E32221850
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 21:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOzaWcYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfB0V2F (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:28:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38983 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfB0V2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 16:28:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so21066038qtk.6;
        Wed, 27 Feb 2019 13:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6K1Nk891ofgO/1fLA3BZfYEmuH5dMDFW0GKa96n+hDE=;
        b=iOzaWcYbZahdTj6uyCFkm+3bgR+SIaAvVSSvnlaHEaMBzwY1NkP8tv2+9WL+DfTQHb
         239VeyjRgWy+s5FnUlhzHr49v+2/yaENfxZ6o8px4YG+NAsqg93sVbKl4ZuqsL78UQ05
         uDlmSChuywdkTi0l5WJVIqUZoprPSiTSUl6jLmyfd6oyYzv7/Bp+R75TTwBBF90vIoTG
         3ge/ODVccawGTVvEE47/Nk1NMxWPqKJ7mIYpCRvVjJqoadwhD1jROYPLPxoRzH0+n1Mg
         ntHv2FVKLRLJqQeq/zXylxvnwcQCtRAOddjiN6q6rDiGUiNkoFF32F1kdcHTcsDDWN7O
         Ziqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6K1Nk891ofgO/1fLA3BZfYEmuH5dMDFW0GKa96n+hDE=;
        b=PBXAXN2O9fTUNoW4uxLZ4GsAZrTpcVlQA11FHZJCZGT5qQI8qo/V63ZmR05PNmoJ7U
         VLaCnb37MbJWXs2tc9wGj54hW/VDU4nsY3QJuuy8NUMW7+bgxJKeYq8yTtG/xUkzNVHv
         mell5bybfstQtnCWQfXIcNB3nXaW6JC9BQk5Hz2FKMdzkfZ21T+uuz6uri98Sf3Oplkz
         8w7BR+Z9q/i0AKjj59UudLvHYhVYeY1wHNA20oeLdRQpCl6uVqtnBKi5HZ4gGQ6N9UJz
         qcRAjEddsLlC1B/lEckESNvdeyVauWZCsTtgWKhjgDLT6Q+am5Pr1ybB68fGQunIiJ+w
         AVxg==
X-Gm-Message-State: AHQUAuabz0BFiqnvSmfDhBkLLmiwOWytxt4NOYf2pXYhUodmY03uWqf9
        3Nk8ExWmCTgoNUS5aoUFC6yBw8RTi9DhtOZRnCo=
X-Google-Smtp-Source: AHgI3IYgJ4TWZFmvF5K8rOafhyZvlOi6It3cyifYejN/4eBsHzQUcsIM2NSPSFlrIMgwWCf+OLwlc6ZNzjd+RoLPIZo=
X-Received: by 2002:ac8:2668:: with SMTP id v37mr3562727qtv.263.1551302884383;
 Wed, 27 Feb 2019 13:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20190227191511.80859-1-sdf@google.com>
In-Reply-To: <20190227191511.80859-1-sdf@google.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 27 Feb 2019 13:27:52 -0800
Message-ID: <CAPhsuW5H+9s6pi1i73vnzFNWBa-jq-jxGo4cf9EqU6F7JEHZPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: use __bpf_constant_htons in
 test_prog.c for flow dissector
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 11:16 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> Older GCC (<4.8) isn't smart enough to optimize !__builtin_constant_p()
> branch in bpf_htons.
>
> I recently fixed it for pkt_v4 and pkt_v6 in commit a0517a0f7ef23
> ("selftests/bpf: use __bpf_constant_htons in test_prog.c"), but later
> added another bunch of bpf_htons in commit bf0f0fd939451 ("selftests/bpf:
> add simple BPF_PROG_TEST_RUN examples for flow dissector").
>
> Fixes: bf0f0fd939451 ("selftests/bpf: add simple BPF_PROG_TEST_RUN examples for flow dissector")
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/test_progs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index c59d2e015d16..87cde42559f7 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1954,7 +1954,7 @@ static struct bpf_flow_keys pkt_v4_flow_keys = {
>         .thoff = sizeof(struct iphdr),
>         .addr_proto = ETH_P_IP,
>         .ip_proto = IPPROTO_TCP,
> -       .n_proto = bpf_htons(ETH_P_IP),
> +       .n_proto = __bpf_constant_htons(ETH_P_IP),
>  };
>
>  static struct bpf_flow_keys pkt_v6_flow_keys = {
> @@ -1962,7 +1962,7 @@ static struct bpf_flow_keys pkt_v6_flow_keys = {
>         .thoff = sizeof(struct ipv6hdr),
>         .addr_proto = ETH_P_IPV6,
>         .ip_proto = IPPROTO_TCP,
> -       .n_proto = bpf_htons(ETH_P_IPV6),
> +       .n_proto = __bpf_constant_htons(ETH_P_IPV6),
>  };
>
>  static void test_flow_dissector(void)
> --
> 2.21.0.rc2.261.ga7da99ff1b-goog
>
