Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14438C282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D601D21773
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="Le6zSC4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfDXPmJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:42:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41538 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbfDXPmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 11:42:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so9559485pgs.8
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MQdd9eOfOhmscSdRZrlX9EuClR1SERHeGHLgz18WGxM=;
        b=Le6zSC4JjyCPHJgr/0XeugpBA9BpeCDKsqFuZehzPLYDdFmVwDJJ01UaAfkioQPGnY
         Ird3SkdVfSDtTdEKB3UeS5jWZNb1USOB4e3u/m/dmwzFZiK/GEEoHVmBJ6h5SeQC5l6q
         mRhxpAIGgeYopF2zK/NgO+8IW26jFJtLFxShm7+4nFTOj66oAd2dou8biKFdhrDJJgM1
         dyCqjHldrkE3fAXtCM1c4CG3vg5pwNjWfKUxswbJJViGz4CPlE6BEQCVaFC2Q+TO5GbW
         D0ymUKZl5yloHgDZ0smvmJk3mS9NrL8zBqF0P9c2OcFwyAXVquObLzi4l+1gqY4Kyxnk
         RFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MQdd9eOfOhmscSdRZrlX9EuClR1SERHeGHLgz18WGxM=;
        b=kWHF6GUVu+6Gc/7uikdUYKepqEVn/4luUgZ6nH/5LyEvxAp87OSv8kP4ntLyBqZ2Rp
         7HWsHND0QejwgCjtEEnaSz9bso6zQkpdysHjeNkhcrR82wyJ9Jb/JpZUa3nea1/qCfsW
         uKx1vhCrUKWIuHAjkvxKdiEMZ1YC9imYLpF3YeNzSRwM7sYaZ45vvtcigrKdHFagveAL
         JAOOEmQ8Dy7EgE2uKAjFCO5Sv3h+WoqGQOBEP/8/bGs2Ph7sP72OpqheKWseG4ILhps0
         jIJj0vtttLtAygGmbKSMCNlvrkNPyem7NkriEOOpsIQ1GRMIseUXfn0zVSAPcTHTSzwq
         7x1A==
X-Gm-Message-State: APjAAAWr5xQRv95RXDst+z/OSeJUkEoVeH3oAzFXQzVgwMyMt5S5Cltp
        UoulJB8MKABAJ978psMyYWYJTA==
X-Google-Smtp-Source: APXvYqxqUs76Ge7qBjOu3msm886b+/pHbupq8os8vAuDD/kVCr+zhnmDXJOnsl3RoY6zXCApA/0cSw==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr32201109pgh.263.1556120528382;
        Wed, 24 Apr 2019 08:42:08 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id m131sm45058402pga.3.2019.04.24.08.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 08:42:07 -0700 (PDT)
Date:   Wed, 24 Apr 2019 08:42:06 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com
Subject: Re: [PATCH bpf-next 2/2] bpftool: show flow_dissector attachment
 status
Message-ID: <20190424154206.GC1247@mini-arch>
References: <20190423232200.101627-1-sdf@google.com>
 <20190423232200.101627-2-sdf@google.com>
 <b0713532-87b8-bbba-ba65-dd8778a5ca59@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0713532-87b8-bbba-ba65-dd8778a5ca59@netronome.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/24, Quentin Monnet wrote:
> 2019-04-23 16:22 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> > Right now there is no way to query whether BPF flow_dissector program
> > is attached to a network namespace or not. In previous commit, I added
> > support for querying that info, show it when doing `bpftool net`:
> > 
> > $ bpftool prog loadall ./bpf_flow.o \
> > 	/sys/fs/bpf/flow type flow_dissector \
> > 	pinmaps /sys/fs/bpf/flow
> > $ bpftool prog
> > 3: flow_dissector  name _dissect  tag 8c9e917b513dd5cc  gpl
> >          loaded_at 2019-04-23T16:14:48-0700  uid 0
> >          xlated 656B  jited 461B  memlock 4096B  map_ids 1,2
> >          btf_id 1
> > ...
> > 
> > $ bpftool net -j
> > [{"xdp":[],"tc":[],"flow_dissector":[]}]
> > 
> > $ bpftool prog attach pinned \
> > 	/sys/fs/bpf/flow/flow_dissector flow_dissector
> > $ bpftool net -j
> > [{"xdp":[],"tc":[],"flow_dissector":["id":3]}]
> > 
> > Doesn't show up in a different net namespace:
> > $ ip netns add test
> > $ ip netns exec test bpftool net -j
> > [{"xdp":[],"tc":[],"flow_dissector":[]}]
> > 
> > Non-json output:
> > $ bpftool net
> > xdp:
> > 
> > tc:
> > 
> > flow_dissector:
> > id 3
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   tools/bpf/bpftool/net.c | 52 +++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> > 
> > diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> > index db0e7de49d49..afe0903201e2 100644
> > --- a/tools/bpf/bpftool/net.c
> > +++ b/tools/bpf/bpftool/net.c
> 
> > @@ -48,6 +51,10 @@ struct bpf_filter_t {
> >   	int		ifindex;
> >   };
> > +struct bpf_attach_info {
> > +	__u32 flow_dissector_id;
> > +};
> > +
> >   static int dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
> >   {
> >   	struct bpf_netdev_t *netinfo = cookie;
> > @@ -180,8 +187,43 @@ static int show_dev_tc_bpf(int sock, unsigned int nl_pid,
> >   	return 0;
> >   }
> > +static int query_flow_dissector(struct bpf_attach_info *attach_info)
> > +{
> > +	__u32 prog_ids[1] = {0};
> > +	__u32 prog_cnt = ARRAY_SIZE(prog_ids);
> > +	__u32 attach_flags;
> > +	int fd;
> > +	int err;
> > +
> > +	fd = open("/proc/self/ns/net", O_RDONLY);
> > +	if (fd < 0) {
> > +		p_err("can't open /proc/self/ns/net: %d",
> > +		      strerror(errno));
> > +		return -1;
> > +	}
> > +	err = bpf_prog_query(fd, BPF_FLOW_DISSECTOR, 0,
> > +			     &attach_flags, prog_ids, &prog_cnt);
> > +	close(fd);
> > +	if (err) {
> > +		if (errno == EINVAL) {
> > +			/* Older kernel's don't support querying
> > +			 * flow dissector programs.
> > +			 */
> > +			return 0;
> 
> Hi Stanislav,
> 
> If we handle the "error" gracefully here, should we maybe reset errno to 0
> before returning? Batch mode, for example, stops processing commands when it
> sees that errno is set, but we probably want it to continue in the current
> case (commit 39c9f10639a3 addressed something similar for "bpftool cgroup
> tree").
Oh, I didn't know that. Sure, will do!

> > +		}
> > +		p_err("can't query prog: %s", strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	if (prog_cnt == 1)
> > +		attach_info->flow_dissector_id = prog_ids[0];
> > +
> > +	return 0;
> > +}
> > +
> >   static int do_show(int argc, char **argv)
> >   {
> > +	struct bpf_attach_info attach_info = {};
> >   	int i, sock, ret, filter_idx = -1;
> >   	struct bpf_netdev_t dev_array;
> >   	unsigned int nl_pid;
