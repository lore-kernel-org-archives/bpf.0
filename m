Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD8C10F03
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AEC20449
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="MYfYKKmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfDWXcu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:32:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39688 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfDWXcu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 19:32:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id f125so4918912qke.6
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nB0k3vz+Cyco9m+wyMB/wOMAcOLFsW7GzOUc5z1dGYo=;
        b=MYfYKKmPxODpi3ghUhlQxgKBL6lBp6JodPqMeKSQWzHse+50GJQ7V8HBPJSYt45EYu
         AOY56GZVbOUOvZsFqwyIxFeC28MrgxC8ASftjzBOLdmkqfeotaSopBmtLY536qFbJMjv
         2SAeL6mlrV3D9jL2RpM7Wc6MaASS51+v6MRpUYi57XuiO395zFt3Ijtcytu+gAeCz6XF
         T4qrhRfK/vlLm/WxL0nJ2GWgavcEb9y1q9DiCGD7hbrwrjKPb8UIA4WL7giMUfJicVDZ
         7mb50Qo45uACOaWTJQEM7GrHSleBz4ZvmeUjqjXA0rx+jcrnEXIOdUtEHjgX8NiogSML
         vf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nB0k3vz+Cyco9m+wyMB/wOMAcOLFsW7GzOUc5z1dGYo=;
        b=HixtJJrgX7AOqNeUDm1MDTL+yvCjDEg+faCsZRLvJOknKUmfhgxexkB/r2FZ274aZM
         ZCvtDODuYidG3FzXN9HpQFrslcmh//yzegh7q6zA48ODdoFss5UZD9eHVpFR/a2FW6km
         2bBUXRPoRH8TskxFqcPee5mRvT2Rv3IneM70IAk2tRN5kFNQgNUveI4Lvb8dBP9102Vl
         InyFe1MF6EgIX6Y94hpPjM3FmwO9N1HK4oVHTqebrXIzo3kqqxVuWVW2xv/4ogZKANWU
         KpCafxYlmRTucx+e5lLaqV3zVIp0MtWL6gg8gf8BxBJqH6O/tm8KFmLYDuthr9Pj83eD
         +GcA==
X-Gm-Message-State: APjAAAVrKhigjEYB+U/2BR0LXzjUrD7clHGWrRAL00kJWffU3Neehy4k
        jWs+fe6AT7R7yi0yumLBeVRKKA==
X-Google-Smtp-Source: APXvYqzc1hjTfHbCMOTAMLng7F/IYP9cQbkqcbQGT7iaH8I1XP5Jsb124IpvR0F4V0wIo7TH1qz8zQ==
X-Received: by 2002:ae9:c005:: with SMTP id u5mr11465706qkk.179.1556062369152;
        Tue, 23 Apr 2019 16:32:49 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u3sm8343850qkc.21.2019.04.23.16.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 16:32:49 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:32:44 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, quentin.monnet@netronome.com
Subject: Re: [PATCH bpf-next 2/2] bpftool: show flow_dissector attachment
 status
Message-ID: <20190423163244.0a665bb0@cakuba.netronome.com>
In-Reply-To: <20190423232200.101627-2-sdf@google.com>
References: <20190423232200.101627-1-sdf@google.com>
        <20190423232200.101627-2-sdf@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Apr 2019 16:22:00 -0700, Stanislav Fomichev wrote:
> +static int query_flow_dissector(struct bpf_attach_info *attach_info)
> +{
> +	__u32 prog_ids[1] = {0};
> +	__u32 prog_cnt = ARRAY_SIZE(prog_ids);
> +	__u32 attach_flags;
> +	int fd;
> +	int err;

reverse christmas tree, please :)

Move the init into the code if necessary.

> +	fd = open("/proc/self/ns/net", O_RDONLY);
> +	if (fd < 0) {
> +		p_err("can't open /proc/self/ns/net: %d",
> +		      strerror(errno));
> +		return -1;
> +	}
> +	err = bpf_prog_query(fd, BPF_FLOW_DISSECTOR, 0,
> +			     &attach_flags, prog_ids, &prog_cnt);
> +	close(fd);
> +	if (err) {
> +		if (errno == EINVAL) {
> +			/* Older kernel's don't support querying
> +			 * flow dissector programs.
> +			 */
> +			return 0;
> +		}
> +		p_err("can't query prog: %s", strerror(errno));
> +		return -1;
> +	}
> +
> +	if (prog_cnt == 1)
> +		attach_info->flow_dissector_id = prog_ids[0];

So the count can only be 0 or 1?  Hm.

> +	return 0;
> +}
