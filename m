Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF1EC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 20:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DE02089E
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 20:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFxMFgHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfDYUzT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:55:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33672 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfDYUzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 16:55:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so849325lfm.0;
        Thu, 25 Apr 2019 13:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/MO0Q8E7Llrq9ti3SuADVY3l7bhy3s7VDLDjG8/IPQ=;
        b=FFxMFgHk3a/0flwa6maAEIsUnTFR0Xo8PiHKRKMJr77ayfPwoo3XCvqFheUP0xKmEs
         A9RXrxKH1PQ7SRjfNj2EndvciTolBBT2YVJd9VeUc5Q//yeoZUApb353dHVHTurI4PEs
         1szpbJGycBVXqaaOY/u34QRMoH3x3ljlhEMiLsX23ure3i1SU7Q+eUAm134zROyuHWen
         skGTDKM8aAlLeUAnhQj7ddDQ0jby/Euy5uhGh9Djwpx/1bXUy07w+SmnzahnyAWRGR5C
         mTBpdKQ4Yyu1VLqC/XnHn0WHFVYNFibLEZ0cqBwwl+1Sw9fPMuLne9/VhMiaz/K4t8wm
         QQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/MO0Q8E7Llrq9ti3SuADVY3l7bhy3s7VDLDjG8/IPQ=;
        b=o/vzKu6za6cA3ug+VRM3+4zIjWT6deDyWjbJNnVV9nfyOEoNAc9zPC88GNzYmQfLrX
         ynSXuOd3PUnL3ITWLYeLLDWp1QMarcw+MzhsVGxOGmWRCE1DS57dd1cLCsGKiyaLasGl
         TNeju7USUttVGSEFo4s1E0aNbxMdXO2aLS0DGir1+MMzMdRDYfbFSVMTD9Vj5DWEQp61
         bmMV3ceQV3e8Yebs/w6jlRwjJvnm75RqyvgXbcBHpDfva4aQPHG0wAzZIG/4YlYczfYl
         FF+oz11NKapehZuG61jOXlhjCGWZT4xueq2zxOhU7gTp+oU+C9xOGBB/4KHH+AZV6wyM
         7msA==
X-Gm-Message-State: APjAAAVQrflouPVlmWE2LKY24ew26f/cQt6M23uYV6Uv91DUFXaTv931
        EmRYl7PaFp1bT+vOk5czwN7o89VLlojgrnJLCvs=
X-Google-Smtp-Source: APXvYqzCNwHp0c+VjESKD7BCgHCiw5wF2pPgO+/W6DdUoS/LK92uysyLEvAuhOM1AL60aGS0Do9sMFE7EMFPUH7HN4I=
X-Received: by 2002:ac2:54a9:: with SMTP id w9mr22174997lfk.125.1556225717177;
 Thu, 25 Apr 2019 13:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556059361.git.daniel@iogearbox.net>
In-Reply-To: <cover.1556059361.git.daniel@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Apr 2019 13:54:43 -0700
Message-ID: <CAADnVQL=OmaUXpO5tA9y0EmMaEdZbHogB7hVe-_T-VwH+rKsPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Two libbpf fixes
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 23, 2019 at 3:46 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Two small fixes in relation to global data handling. Thanks!

Applied. Thanks!
