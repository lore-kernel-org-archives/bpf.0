Return-Path: <SRS0=NOCw=DA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E21C4363D
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 04:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A000421941
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 04:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/ksssDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgIWEtU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Sep 2020 00:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgIWEtU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 00:49:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFCDC061755;
        Tue, 22 Sep 2020 21:49:19 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g96so17770815otb.12;
        Tue, 22 Sep 2020 21:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZIAcLimMkOKDbV/rs6yq2lc1nezxyw1NdVdfblTYl4o=;
        b=f/ksssDOxmd5elpm02DzDy+hAH8KodWTkuDDVBfU7UQJT/zYln5EA9k3aqywYNOOGW
         0zbvfQOiF2fCLehUrokYfP/7WHwHBoqoAmiwgWQsRFuciR5ATPUJdXQr5/2Vr117qhVr
         JJ7pUDO7edIwIt92BMCXODMuqoeAzWYwDTk2UeGGVlUKWJ1HlXpM7xQmGZX/dNUC4drN
         xqvZBEvysR2OcS+2EKxVP0sB2+GaH5b2gZMBCtizipuG5QR8tMn61/YfvvUCyW5MjcOf
         XYZ9mGKuXg0Q7WY9rFVlGtKk/YbKsNivNZQHHM8+vfEZL2zh03b/Ps5gpeE+dVFhgHoT
         byPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZIAcLimMkOKDbV/rs6yq2lc1nezxyw1NdVdfblTYl4o=;
        b=AFvqTu1ULReC5lh8QULT3FZUhUtsBANVV138m4TZneXSyTlt2ZoZToKtlqCgbtvZco
         TItirxyuGengldpRtFK6It0/clGTizvq3mBuHasDF0e284Vh8NuyR8RcLW56tyK+5AuL
         TZB8AsXFZBLArwDWVfSSTDy2L5JI2qHyRdoa4PwUhp3bwQVIyjV1fQGwWqWgDUrML8OF
         1KBANqWgpYMbHjRAbkpDFJmzZ76O5X7Q8LENyjIA+NpUHLtOijkxVkEpymh3ig7/rnCl
         +VVg3YTXg0npmJLfMVO9BscjQEYGBAjkYmDlMg+4t/qLlsSHMkih4f8LJ1Af4Rc+wgFZ
         DHBg==
X-Gm-Message-State: AOAM531ggT7BktI6nzq0sMSstDmb9B3xpa6lV/fhmyGRo02POqvjvTrI
        SQsFrwhjZsJq1d0Q9kWt3Og=
X-Google-Smtp-Source: ABdhPJwgnWbKdIPTKLCGeyplTJYBbgR892qSFr1r5KtcLy49q/KIjquJxeZKNq9I44LTTlQmadDwXA==
X-Received: by 2002:a9d:ae8:: with SMTP id 95mr5260541otq.260.1600836558712;
        Tue, 22 Sep 2020 21:49:18 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id v25sm7443849ota.39.2020.09.22.21.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 21:49:18 -0700 (PDT)
Date:   Tue, 22 Sep 2020 21:49:10 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Song Liu <songliubraving@fb.com>
Message-ID: <5f6ad3c63a2de_36578208a2@john-XPS-13-9370.notmuch>
In-Reply-To: <20200923012841.2701378-4-songliubraving@fb.com>
References: <20200923012841.2701378-1-songliubraving@fb.com>
 <20200923012841.2701378-4-songliubraving@fb.com>
Subject: RE: [PATCH bpf-next 3/3] selftests/bpf: add raw_tp_test_run
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu wrote:
> This test runs test_run for raw_tracepoint program. The test covers ctx
> input, retval output, and proper handling of cpu_plus field.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---

[...]

> +
> +	test_attr.ctx_size_in = sizeof(args);
> +	err = bpf_prog_test_run_xattr(&test_attr);
> +	CHECK(err < 0, "test_run", "err %d\n", errno);
> +	CHECK(test_attr.retval != expected_retval, "check_retval",
> +	      "expect 0x%x, got 0x%x\n", expected_retval, test_attr.retval);
> +
> +	for (i = 0; i < nr_online; i++)
> +		if (online[i]) {
> +			DECLARE_LIBBPF_OPTS(bpf_prog_test_run_opts, opts,
> +				.cpu_plus = i + 1,
> +			);
> +			err = bpf_prog_test_run_xattr_opts(&test_attr, &opts);
> +			CHECK(err < 0, "test_run_with_opts", "err %d\n", errno);
> +			CHECK(skel->data->on_cpu != i, "check_on_cpu",
> +			      "got wrong value\n");

Should we also check retval here just to be thorough?

Thanks,
John

> +		}
> +cleanup:
> +	close(comm_fd);
> +	test_raw_tp_test_run__destroy(skel);
> +	free(online);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_raw_tp_test_run.c b/tools/testing/selftests/bpf/progs/test_raw_tp_test_run.c
