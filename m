Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD12BC43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 17:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D97F20656
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 17:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="wUbXwyhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfDZRzF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:55:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38939 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZRzF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 13:55:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so2080812pfo.6
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1/3ZEK4opYXkBrbffo8otVV71HkYz+TgoYienDeHrMI=;
        b=wUbXwyhH8pgoAqFC0F/CncUNYcI8QkZgNndqR1b4h+SRUj7itTM1+FAlW2nCLz4xIc
         6B454i8418wPd7+YhfOVlLi493C6FUzjlCPnxoC9frNmhSYRSUffpZ8dsXS3p9HQWAo4
         kbmKzaywVnVQMOFnczN7MEtk0HmtouochKA2/H5hNzq6z5hYU9G6GlDZ+mIdnyf7gBAC
         FWyE43h2k8+z0yu2Gf5XKF11mrJfXR6qc8cH7DczGcyeVfRRabWO3pe/jT1QwyueJ2or
         aFWw8jKSbGw9iE6ULRPMT1yaTVTv5Ip8SMX75+w1VJvR3eDBAUESnX4cRatkYf6BU7XU
         q6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/3ZEK4opYXkBrbffo8otVV71HkYz+TgoYienDeHrMI=;
        b=L2hF+jOQfLdX3ghZyWiBX5kLSF1sz1ebUmCtcC5Yf7rl6Ah/jRLnMA1VTjaL78qXTP
         d47JTokgANFfHibBh9Vdn9WyrvDnEPFVovyUDLHp/X3v+XHRWMsyKg6QKyUlJyr9JSUd
         O1SGQiX4H1geapiaeZoPNyrR8+D+EKX2vec0P3Pxyv6nou5E+2/eKTnXxKDCXzP4ONcS
         dijb6tKyGF98q55SyK7kmNfmXNAsyQ+BwGHvnvvmq28ROy6q3fIMHnhlzODL/W2cqku4
         Rul9IaZUR8drcOa7gnfDftiI3ZPlaSg+l3/qMz1dKfxjwrS0fSmYXI2jahwYi4JCL0U5
         eLhg==
X-Gm-Message-State: APjAAAWe8yW6Ym3Q4EQTMwQ11ZTs0zz9dooFIbuAxPIXNUJZEL84HXQn
        RswNi85o6FWFsS7gFwj5LBPnWA==
X-Google-Smtp-Source: APXvYqw9YOB6Upikh9pDv4vlV1gCthdYp+2GKFsM6ibwG9T87sQzgre6v/0EXIPm8IGT3VNchFNS+Q==
X-Received: by 2002:a62:424b:: with SMTP id p72mr46892934pfa.167.1556301304209;
        Fri, 26 Apr 2019 10:55:04 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id 14sm889681pfx.13.2019.04.26.10.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:55:03 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:55:02 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3 bpf-next 6/6] bpf: Add ene-to-end test for
 bpf_sk_storage_* helpers
Message-ID: <20190426175502.GG1247@mini-arch>
References: <20190426171102.61757-1-kafai@fb.com>
 <20190426171114.62466-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426171114.62466-1-kafai@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/26, Martin KaFai Lau wrote:
> This patch rides on an existing BPF_PROG_TYPE_CGROUP_SKB test
> (test_sock_fields.c) to do a TCP end-to-end test on the new
> bpf_sk_storage_* helpers.
> 
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  tools/testing/selftests/bpf/bpf_helpers.h     |   5 +
>  .../bpf/progs/test_sock_fields_kern.c         |  49 ++++++++
>  .../testing/selftests/bpf/test_sock_fields.c  | 115 +++++++++++++++---
>  3 files changed, 153 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
> index 59e221586cf7..6e80b66d7fb1 100644
> --- a/tools/testing/selftests/bpf/bpf_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_helpers.h
> @@ -211,6 +211,11 @@ static int (*bpf_strtol)(const char *buf, unsigned long long buf_len,
>  static int (*bpf_strtoul)(const char *buf, unsigned long long buf_len,
>  			  unsigned long long flags, unsigned long *res) =
>  	(void *) BPF_FUNC_strtoul;
> +static void *(*bpf_sk_storage_get)(void *map, struct bpf_sock *sk,
> +				   void *value, __u64 flags) =
> +	(void *) BPF_FUNC_sk_storage_get;
> +static int (*bpf_sk_storage_delete)(void *map, struct bpf_sock *sk) =
> +	(void *)BPF_FUNC_sk_storage_delete;
>  
>  /* llvm builtin functions that eBPF C program may use to
>   * emit BPF_LD_ABS and BPF_LD_IND instructions
> diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c b/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
> index 37328f148538..93ef3e039da3 100644
> --- a/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
> @@ -55,6 +55,31 @@ struct bpf_map_def SEC("maps") linum_map = {
>  	.max_entries = __NR_BPF_LINUM_ARRAY_IDX,
>  };
>  
> +struct bpf_spinlock_cnt {
> +	struct bpf_spin_lock lock;
> +	__u32 cnt;
> +};
> +
> +struct bpf_map_def SEC("maps") sk_pkt_out_cnt = {
> +	.type = BPF_MAP_TYPE_SK_STORAGE,
> +	.key_size = sizeof(int),
> +	.value_size = sizeof(struct bpf_spinlock_cnt),
> +	.max_entries = 0,
> +	.map_flags = BPF_F_NO_PREALLOC,
> +};
> +
> +BPF_ANNOTATE_KV_PAIR(sk_pkt_out_cnt, int, struct bpf_spinlock_cnt);
> +
> +struct bpf_map_def SEC("maps") sk_pkt_out_cnt10 = {
> +	.type = BPF_MAP_TYPE_SK_STORAGE,
> +	.key_size = sizeof(int),
> +	.value_size = sizeof(struct bpf_spinlock_cnt),
> +	.max_entries = 0,
> +	.map_flags = BPF_F_NO_PREALLOC,
> +};
> +
> +BPF_ANNOTATE_KV_PAIR(sk_pkt_out_cnt10, int, struct bpf_spinlock_cnt);
> +
>  static bool is_loopback6(__u32 *a6)
>  {
>  	return !a6[0] && !a6[1] && !a6[2] && a6[3] == bpf_htonl(1);
> @@ -120,7 +145,9 @@ static void tpcpy(struct bpf_tcp_sock *dst,
>  SEC("cgroup_skb/egress")
>  int egress_read_sock_fields(struct __sk_buff *skb)
>  {
> +	struct bpf_spinlock_cnt cli_cnt_init = { .lock = 0, .cnt = 0xeB9F };
>  	__u32 srv_idx = ADDR_SRV_IDX, cli_idx = ADDR_CLI_IDX, result_idx;
> +	struct bpf_spinlock_cnt *pkt_out_cnt, *pkt_out_cnt10;
>  	struct sockaddr_in6 *srv_sa6, *cli_sa6;
>  	struct bpf_tcp_sock *tp, *tp_ret;
>  	struct bpf_sock *sk, *sk_ret;
> @@ -161,6 +188,28 @@ int egress_read_sock_fields(struct __sk_buff *skb)
>  	skcpy(sk_ret, sk);
>  	tpcpy(tp_ret, tp);
>  
> +	if (result_idx == EGRESS_SRV_IDX) {
> +		/* The userspace has created it for srv sk */
> +		pkt_out_cnt = bpf_sk_storage_get(&sk_pkt_out_cnt, sk, 0, 0);
> +		pkt_out_cnt10 = bpf_sk_storage_get(&sk_pkt_out_cnt10, sk,
> +						   0, 0);
> +	} else {
> +		pkt_out_cnt = bpf_sk_storage_get(&sk_pkt_out_cnt, sk,
> +						 &cli_cnt_init,
> +						 BPF_SK_STORAGE_GET_F_CREATE);
> +		pkt_out_cnt10 = bpf_sk_storage_get(&sk_pkt_out_cnt10,
> +						   sk, &cli_cnt_init,
> +						   BPF_SK_STORAGE_GET_F_CREATE);
> +	}
> +
> +	if (!pkt_out_cnt || !pkt_out_cnt10)
> +		RETURN;
> +
[..]
> +	pkt_out_cnt->cnt += 1;
> +	bpf_spin_lock(&pkt_out_cnt10->lock);
> +	pkt_out_cnt10->cnt += 10;
> +	bpf_spin_unlock(&pkt_out_cnt10->lock);
Any reason only cnt10 is spin-locked? I see both of them use
bpf_spinlock_cnt struct.

> +
>  	RETURN;
>  }
>  
> diff --git a/tools/testing/selftests/bpf/test_sock_fields.c b/tools/testing/selftests/bpf/test_sock_fields.c
> index dcae7f664dce..550baf8aa1ca 100644
> --- a/tools/testing/selftests/bpf/test_sock_fields.c
> +++ b/tools/testing/selftests/bpf/test_sock_fields.c
> @@ -35,6 +35,11 @@ enum bpf_linum_array_idx {
>  	__NR_BPF_LINUM_ARRAY_IDX,
>  };
>  
> +struct bpf_spinlock_cnt {
> +	struct bpf_spin_lock lock;
> +	__u32 cnt;
> +};
> +
>  #define CHECK(condition, tag, format...) ({				\
>  	int __ret = !!(condition);					\
>  	if (__ret) {							\
> @@ -50,6 +55,8 @@ enum bpf_linum_array_idx {
>  #define DATA_LEN sizeof(DATA)
>  
>  static struct sockaddr_in6 srv_sa6, cli_sa6;
> +static int sk_pkt_out_cnt10_fd;
> +static int sk_pkt_out_cnt_fd;
>  static int linum_map_fd;
>  static int addr_map_fd;
>  static int tp_map_fd;
> @@ -220,28 +227,90 @@ static void check_result(void)
>  	      "Unexpected listen_tp", "Check listen_tp output. ingress_linum:%u",
>  	      ingress_linum);
>  
> -	CHECK(srv_tp.data_segs_out != 1 ||
> +	CHECK(srv_tp.data_segs_out != 2 ||
>  	      srv_tp.data_segs_in ||
>  	      srv_tp.snd_cwnd != 10 ||
>  	      srv_tp.total_retrans ||
> -	      srv_tp.bytes_acked != DATA_LEN,
> +	      srv_tp.bytes_acked != 2 * DATA_LEN,
>  	      "Unexpected srv_tp", "Check srv_tp output. egress_linum:%u",
>  	      egress_linum);
>  
>  	CHECK(cli_tp.data_segs_out ||
> -	      cli_tp.data_segs_in != 1 ||
> +	      cli_tp.data_segs_in != 2 ||
>  	      cli_tp.snd_cwnd != 10 ||
>  	      cli_tp.total_retrans ||
> -	      cli_tp.bytes_received != DATA_LEN,
> +	      cli_tp.bytes_received != 2 * DATA_LEN,
>  	      "Unexpected cli_tp", "Check cli_tp output. egress_linum:%u",
>  	      egress_linum);
>  }
>  
> +static void check_sk_pkt_out_cnt(int accept_fd, int cli_fd)
> +{
> +	struct bpf_spinlock_cnt pkt_out_cnt = {} , pkt_out_cnt10 = {};
> +	int err;
> +
> +	pkt_out_cnt.cnt = ~0;
> +	pkt_out_cnt10.cnt = ~0;
> +	err = bpf_map_lookup_elem(sk_pkt_out_cnt_fd, &accept_fd, &pkt_out_cnt);
> +	if (!err)
> +		err = bpf_map_lookup_elem(sk_pkt_out_cnt10_fd, &accept_fd,
> +					  &pkt_out_cnt10);
> +
> +	/* The bpf prog only counts for fullsock and
> +	 * passive conneciton did not become fullsock until 3WHS
> +	 * had been finished.
> +	 * The bpf prog only counted two data packet out but we
> +	 * specially init accept_fd's pkt_out_cnt by 2 in
> +	 * init_sk_storage().  Hence, 4 here.
> +	 */
> +	CHECK(err || pkt_out_cnt.cnt != 4 || pkt_out_cnt10.cnt != 40,
> +	      "bpf_map_lookup_elem(sk_pkt_out_cnt, &accept_fd)",
> +	      "err:%d errno:%d pkt_out_cnt:%u pkt_out_cnt10:%u",
> +	      err, errno, pkt_out_cnt.cnt, pkt_out_cnt10.cnt);
> +
> +	pkt_out_cnt.cnt = ~0;
> +	pkt_out_cnt10.cnt = ~0;
> +	err = bpf_map_lookup_elem(sk_pkt_out_cnt_fd, &cli_fd, &pkt_out_cnt);
> +	if (!err)
> +		err = bpf_map_lookup_elem(sk_pkt_out_cnt10_fd, &cli_fd,
> +					  &pkt_out_cnt10);
> +	/* Active connection is fullsock from the beginning.
> +	 * 1 SYN and 1 ACK during 3WHS
> +	 * 2 Acks on data packet.
> +	 *
> +	 * The bpf_prog initialized it to 0xeB9F.
> +	 */
> +	CHECK(err || pkt_out_cnt.cnt != 0xeB9F + 4 ||
> +	      pkt_out_cnt10.cnt != 0xeB9F + 40,
> +	      "bpf_map_lookup_elem(sk_pkt_out_cnt, &cli_fd)",
> +	      "err:%d errno:%d pkt_out_cnt:%u pkt_out_cnt10:%u",
> +	      err, errno, pkt_out_cnt.cnt, pkt_out_cnt10.cnt);
> +}
> +
> +static void init_sk_storage(int sk_fd, __u32 pkt_out_cnt)
> +{
> +	struct bpf_spinlock_cnt scnt = {};
> +	int err;
> +
> +	scnt.cnt = pkt_out_cnt;
> +	err = bpf_map_update_elem(sk_pkt_out_cnt_fd, &sk_fd, &scnt,
> +				  BPF_NOEXIST);
> +	CHECK(err, "bpf_map_update_elem(sk_pkt_out_cnt_fd)",
> +	      "err:%d errno:%d", err, errno);
> +
> +	scnt.cnt *= 10;
> +	err = bpf_map_update_elem(sk_pkt_out_cnt10_fd, &sk_fd, &scnt,
> +				  BPF_NOEXIST);
> +	CHECK(err, "bpf_map_update_elem(sk_pkt_out_cnt10_fd)",
> +	      "err:%d errno:%d", err, errno);
> +}
> +
>  static void test(void)
>  {
>  	int listen_fd, cli_fd, accept_fd, epfd, err;
>  	struct epoll_event ev;
>  	socklen_t addrlen;
> +	int i;
>  
>  	addrlen = sizeof(struct sockaddr_in6);
>  	ev.events = EPOLLIN;
> @@ -308,24 +377,30 @@ static void test(void)
>  	      accept_fd, errno);
>  	close(listen_fd);
>  
> -	/* Send some data from accept_fd to cli_fd */
> -	err = send(accept_fd, DATA, DATA_LEN, 0);
> -	CHECK(err != DATA_LEN, "send(accept_fd)", "err:%d errno:%d",
> -	      err, errno);
> -
> -	/* Have some timeout in recv(cli_fd). Just in case. */
>  	ev.data.fd = cli_fd;
>  	err = epoll_ctl(epfd, EPOLL_CTL_ADD, cli_fd, &ev);
>  	CHECK(err, "epoll_ctl(EPOLL_CTL_ADD, cli_fd)", "err:%d errno:%d",
>  	      err, errno);
>  
> -	err = epoll_wait(epfd, &ev, 1, 1000);
> -	CHECK(err != 1 || ev.data.fd != cli_fd,
> -	      "epoll_wait(cli_fd)", "err:%d errno:%d ev.data.fd:%d cli_fd:%d",
> -	      err, errno, ev.data.fd, cli_fd);
> +	init_sk_storage(accept_fd, 2);
>  
> -	err = recv(cli_fd, NULL, 0, MSG_TRUNC);
> -	CHECK(err, "recv(cli_fd)", "err:%d errno:%d", err, errno);
> +	for (i = 0; i < 2; i++) {
> +		/* Send some data from accept_fd to cli_fd */
> +		err = send(accept_fd, DATA, DATA_LEN, 0);
> +		CHECK(err != DATA_LEN, "send(accept_fd)", "err:%d errno:%d",
> +		      err, errno);
> +
> +		/* Have some timeout in recv(cli_fd). Just in case. */
> +		err = epoll_wait(epfd, &ev, 1, 1000);
> +		CHECK(err != 1 || ev.data.fd != cli_fd,
> +		      "epoll_wait(cli_fd)", "err:%d errno:%d ev.data.fd:%d cli_fd:%d",
> +		      err, errno, ev.data.fd, cli_fd);
> +
> +		err = recv(cli_fd, NULL, 0, MSG_TRUNC);
> +		CHECK(err, "recv(cli_fd)", "err:%d errno:%d", err, errno);
> +	}
> +
> +	check_sk_pkt_out_cnt(accept_fd, cli_fd);
>  
>  	close(epfd);
>  	close(accept_fd);
> @@ -395,6 +470,14 @@ int main(int argc, char **argv)
>  	CHECK(!map, "cannot find linum_map", "(null)");
>  	linum_map_fd = bpf_map__fd(map);
>  
> +	map = bpf_object__find_map_by_name(obj, "sk_pkt_out_cnt");
> +	CHECK(!map, "cannot find sk_pkt_out_cnt", "(null)");
> +	sk_pkt_out_cnt_fd = bpf_map__fd(map);
> +
> +	map = bpf_object__find_map_by_name(obj, "sk_pkt_out_cnt10");
> +	CHECK(!map, "cannot find sk_pkt_out_cnt10", "(null)");
> +	sk_pkt_out_cnt10_fd = bpf_map__fd(map);
> +
>  	test();
>  
>  	bpf_object__close(obj);
> -- 
> 2.17.1
> 
