Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB37C67871
	for <bpf@archiver.kernel.org>; Mon, 24 Oct 2022 23:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiJXXR4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiJXXRh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 19:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51102E16D5
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666647481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S479Dg5sGBB/fotobSx8FUYeDMB6rzD4KGpjRiYIypU=;
        b=PGHRlIM3cKv7Lw+xP14/jmNPAZpm/FOPMpsVqVPdlbvEx/vltCKDs4Jo2v/bsavFXae+L1
        nNaJioo0me/i594WTJnPhSL5gE0FyuQmFtyxz+b/ejiNcG8F92uf/4eaDE/a0xZeuPIe/s
        960sBZWkoJ9JywnzR4OC0vEjzjiiRtM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-MzdgXj4bN16idrTrtdChOw-1; Mon, 24 Oct 2022 08:01:21 -0400
X-MC-Unique: MzdgXj4bN16idrTrtdChOw-1
Received: by mail-qv1-f70.google.com with SMTP id mi12-20020a056214558c00b004bb63393567so1707124qvb.21
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 05:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S479Dg5sGBB/fotobSx8FUYeDMB6rzD4KGpjRiYIypU=;
        b=tvjYl3ps9jubAJknERTM/Kx0zRZaDQ8YKX/1zaSE8nuWcCLYNezsO0gQ9UZrcrSs2t
         3fevT2OqOza/TyLWccarxjSbF013slx3wx7f42x/EWlL7FUVG0WzmRQp09jLFpd4m664
         RZh/4c4JuOJme2HFlXT4+3kZJRN7HNs+6NmeQPD0oh67AbWMDWpod2GPHoGi8CNiNXfq
         cdiSdNpsLuBfDdOj+udb8Bl5NcklADmxRHLNsVy2txQ2CVs6LRwgkLNvxMURkFj7qCPa
         YxFu7Nm77T+lBu8L5BrDPuy3PfIMWvlaZV+kQ4hxU5biRgD26Pbu6sJ42clge3awhN3U
         RvUg==
X-Gm-Message-State: ACrzQf0Pn2Kj5IpBz+CiYpe/LV1HiI+FhK5vWhvQ2xiXVd4HdbSrD6Go
        O2JQ7ypt4jcHb47gqD+Pimwtpsf9ofBhq8WQGnxCpFSJXmIKaRbIGgZpnN7UF5sOLeV7oCE6md9
        1gTMvxspSh3+B
X-Received: by 2002:a05:620a:e8c:b0:6ee:7820:fa2a with SMTP id w12-20020a05620a0e8c00b006ee7820fa2amr22489997qkm.624.1666612877734;
        Mon, 24 Oct 2022 05:01:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7KE6ew29KXR0Yrcpgq8GHmp20ZfeVaOu2QH8p9svifokSCKl53ptU3FYBwzp+lDhOeLp64IQ==
X-Received: by 2002:a05:620a:e8c:b0:6ee:7820:fa2a with SMTP id w12-20020a05620a0e8c00b006ee7820fa2amr22489966qkm.624.1666612877404;
        Mon, 24 Oct 2022 05:01:17 -0700 (PDT)
Received: from [192.168.0.4] ([78.19.70.238])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b0039cc0fbdb61sm12708997qtb.53.2022.10.24.05.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:01:16 -0700 (PDT)
Message-ID: <aa5f3e2e-10d2-ac78-187e-9aed94b11c0c@redhat.com>
Date:   Mon, 24 Oct 2022 13:01:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v8 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk
References: <20221021142259.18093-1-donald.hunter@gmail.com>
 <20221021142259.18093-2-donald.hunter@gmail.com>
Content-Language: en-US
From:   Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <20221021142259.18093-2-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21/10/2022 15:22, Donald Hunter wrote:
> |+.. code-block:: c + + int initialize_array(int fd) + { + int ncpus = 
> libbpf_num_possible_cpus(); + long values[ncpus]; + __u32 i, j; + int 
> ret; + + for (i = 0; i < 256 ; i++) { + for (j = 0; j < ncpus; j++) + 
> values[j] = i; + ret = bpf_map_update_elem(fd, &i, &values, BPF_ANY); + 
> if (ret < 0) + return ret; + } + + return ret;|

Reviewed-by: Maryam Tahhan <mtahhan@redhat.com>

