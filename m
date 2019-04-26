Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C8BC43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020F20656
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 17:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="og21yWGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfDZRyE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:54:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43182 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZRyD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 13:54:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so1902432plp.10
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nBawrVjW/UAF9Lpma8BdXn2k0jS017DvdlfaxgXgZHQ=;
        b=og21yWGkAS7+xV0pqFwwI/4R6aE9dguu/05L2BGc2upV7eleZK+m96SX9EIrwXYZrb
         Cxy6hBYKcnxbn+tAQuv4HNF7LBZ26nKyrKz7KkT6GApVNn0BDKlIaswCRT7wvSrQd/HU
         LqN6WBd5BslAP4Fq6CfoqFyCcMcvgbroEDIUNIDSnG+JfTPvDVQ83Zke4TPDPMixoehz
         Mwwg/+2r1jTLxGzRrwv48YPk03HYooEXeiqDpktet2U/hgA98vYYreysNP2H1K3r9vwc
         YxafKxEcmmlzaJMpoJ2Ql68STiK3Ov6N8+BRwp/JH2Mp/nGTlUvKD1X6/WDb5yw9jjHy
         jXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBawrVjW/UAF9Lpma8BdXn2k0jS017DvdlfaxgXgZHQ=;
        b=BxDk1N5WeGu/XqIOLij0x82Q7K1yZXaMDulB8NmIO6QzBLeINAIFXrBKcnooStT1Mg
         MGe1imadfU0XvaDw6jhjmwsy9rhwbZjinUn0YYBOh9mm32S+8RRP5T+psHwtNYQT8ILa
         T4+AhYsC9MTtzBun/nfpO09a4Az1AeJLm6LdLzgGhkWKarAhFyP3ynreHAf5aZOyAo7f
         Vjcf3E6SGCFrpDKcTyMQofNxi2htCckkKSEQpDleJb/k6e4n5Xi6jA+ZGt9PcQktKMj5
         XrJb8Sv72NAhBRCkXw+W+YD7Tm7NLQMHnhc3NET6iB2kWDsvivsLaiYWRn6XrcaLVnsQ
         /h4A==
X-Gm-Message-State: APjAAAXaE0ckC9J5c8bNFrnHj3gOiXyCAHvKbRnUdlG5q+my+eGxtVCt
        +dY0mqRBD1B90NZffZXzlFGwtQ==
X-Google-Smtp-Source: APXvYqxlEPIxWcE5Vj18zqkA8bCxZlb9lUcySd42/LT+raLHD1Cetw54meixwVQ0AKY+DbI7Q51gzw==
X-Received: by 2002:a17:902:f084:: with SMTP id go4mr48422871plb.235.1556301242717;
        Fri, 26 Apr 2019 10:54:02 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id g63sm39990534pfc.127.2019.04.26.10.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:54:01 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:54:00 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3 bpf-next 5/6] bpf: Add BPF_MAP_TYPE_SK_STORAGE test to
 test_maps
Message-ID: <20190426175400.GF1247@mini-arch>
References: <20190426171102.61757-1-kafai@fb.com>
 <20190426171112.62405-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426171112.62405-1-kafai@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/26, Martin KaFai Lau wrote:
> This patch adds BPF_MAP_TYPE_SK_STORAGE test to test_maps.
> The src file is rather long, so it is put into another dir map_tests/
> and compile like the current prog_tests/ does.  Other existing
> tests in test_maps can also be re-factored into map_tests/ in the
> future.
> 
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  25 +-
>  .../selftests/bpf/map_tests/sk_storage_map.c  | 638 ++++++++++++++++++
>  tools/testing/selftests/bpf/test_maps.c       |  18 +-
>  tools/testing/selftests/bpf/test_maps.h       |  17 +
>  4 files changed, 688 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/map_tests/sk_storage_map.c
>  create mode 100644 tools/testing/selftests/bpf/test_maps.h
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index f9d83ba7843e..66f2dca1dee1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -74,6 +74,8 @@ all: $(TEST_CUSTOM_PROGS)
>  $(OUTPUT)/urandom_read: $(OUTPUT)/%: %.c
>  	$(CC) -o $@ $< -Wl,--build-id
>  
> +$(OUTPUT)/test_maps: map_tests/*.c
> +
>  BPFOBJ := $(OUTPUT)/libbpf.a
>  
>  $(TEST_GEN_PROGS): $(BPFOBJ)
> @@ -232,6 +234,27 @@ $(PROG_TESTS_H): $(PROG_TESTS_DIR) $(PROG_TESTS_FILES)
>  		  echo '#endif' \
>  		 ) > $(PROG_TESTS_H))
>  
> +TEST_MAPS_CFLAGS := -I. -I$(OUTPUT)
> +MAP_TESTS_DIR = $(OUTPUT)/map_tests
> +$(MAP_TESTS_DIR):
> +	mkdir -p $@
> +MAP_TESTS_H := $(MAP_TESTS_DIR)/tests.h
> +test_maps.c: $(MAP_TESTS_H)
> +$(OUTPUT)/test_maps: CFLAGS += $(TEST_MAPS_CFLAGS)
> +MAP_TESTS_FILES := $(wildcard map_tests/*.c)
> +$(MAP_TESTS_H): $(MAP_TESTS_DIR) $(MAP_TESTS_FILES)
> +	$(shell ( cd map_tests/; \
> +		  echo '/* Generated header, do not edit */'; \
> +		  echo '#ifdef DECLARE'; \
> +		  ls *.c 2> /dev/null | \
> +			sed -e 's@\([^\.]*\)\.c@extern void test_\1(void);@'; \
> +		  echo '#endif'; \
> +		  echo '#ifdef CALL'; \
> +		  ls *.c 2> /dev/null | \
> +			sed -e 's@\([^\.]*\)\.c@test_\1();@'; \
> +		  echo '#endif' \
> +		 ) > $(MAP_TESTS_H))
> +
>  VERIFIER_TESTS_H := $(OUTPUT)/verifier/tests.h
>  test_verifier.c: $(VERIFIER_TESTS_H)
>  $(OUTPUT)/test_verifier: CFLAGS += $(TEST_VERIFIER_CFLAGS)
> @@ -251,4 +274,4 @@ $(OUTPUT)/verifier/tests.h: $(VERIFIER_TESTS_DIR) $(VERIFIER_TEST_FILES)
>  		 ) > $(VERIFIER_TESTS_H))
>  
>  EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
> -	$(VERIFIER_TESTS_H) $(PROG_TESTS_H)
> +	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H)
> diff --git a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
> new file mode 100644
> index 000000000000..f66e4a3ee6e4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
> @@ -0,0 +1,638 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019 Facebook  */
> +#include <linux/compiler.h>
> +#include <linux/err.h>
> +
> +#include <sys/resource.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <linux/btf.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +
> +#include <test_maps.h>
> +
> +static struct bpf_create_map_attr xattr = {
> +	.name = "sk_storage_map",
> +	.map_type = BPF_MAP_TYPE_SK_STORAGE,
> +	.map_flags = BPF_F_NO_PREALLOC,
> +	.max_entries = 0,
> +	.key_size = 4,
> +	.value_size = 8,
> +	.btf_key_type_id = 1,
> +	.btf_value_type_id = 3,
> +	.btf_fd = -1,
> +};
> +
> +static unsigned int nr_sk_threads_done;
> +static unsigned int nr_sk_threads_err;
> +static unsigned int nr_sk_per_thread = 4096;
> +static unsigned int nr_sk_threads = 4;
> +static int sk_storage_map = -1;
> +static unsigned int stop;
> +static int runtime_s = 5;
> +
> +static bool is_stopped(void)
> +{
> +	return READ_ONCE(stop);
> +}
> +
> +static unsigned int threads_err(void)
> +{
> +	return READ_ONCE(nr_sk_threads_err);
> +}
> +
> +static void notify_thread_err(void)
> +{
> +	__sync_add_and_fetch(&nr_sk_threads_err, 1);
> +}
> +
> +static bool wait_for_threads_err(void)
> +{
> +	while (!is_stopped() && !threads_err())
> +		usleep(500);
> +
> +	return !is_stopped();
> +}
> +
> +static unsigned int threads_done(void)
> +{
> +	return READ_ONCE(nr_sk_threads_done);
> +}
> +
> +static void notify_thread_done(void)
> +{
> +	__sync_add_and_fetch(&nr_sk_threads_done, 1);
> +}
> +
> +static void notify_thread_redo(void)
> +{
> +	__sync_sub_and_fetch(&nr_sk_threads_done, 1);
> +}
> +
> +static bool wait_for_threads_done(void)
> +{
> +	while (threads_done() != nr_sk_threads && !is_stopped() &&
> +	       !threads_err())
> +		usleep(50);
> +
> +	return !is_stopped() && !threads_err();
> +}
> +
> +static bool wait_for_threads_redo(void)
> +{
> +	while (threads_done() && !is_stopped() && !threads_err())
> +		usleep(50);
> +
> +	return !is_stopped() && !threads_err();
> +}
> +
> +static bool wait_for_map(void)
> +{
> +	while (READ_ONCE(sk_storage_map) == -1 && !is_stopped())
> +		usleep(50);
> +
> +	return !is_stopped();
> +}
> +
> +static bool wait_for_map_close(void)
> +{
> +	while (READ_ONCE(sk_storage_map) != -1 && !is_stopped())
> +		;
> +
> +	return !is_stopped();
> +}
> +
> +static int load_btf(void)
> +{
[..]
> +#define BTF_INFO_ENC(kind, kind_flag, vlen) \
> +	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> +#define BTF_TYPE_ENC(name, info, size_or_type) \
> +	(name), (info), (size_or_type)
> +#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
> +	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> +#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
> +	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz),	\
> +	BTF_INT_ENC(encoding, bits_offset, bits)
> +#define BTF_MEMBER_ENC(name, type, bits_offset) \
> +	(name), (type), (bits_offset)
Is it time to move those from test_btf.c to some common place?

> +
> +	const char btf_str_sec[] = "\0bpf_spin_lock\0val\0cnt\0l";
> +	__u32 btf_raw_types[] = {
> +		/* int */
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +		/* struct bpf_spin_lock */                      /* [2] */
> +		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),
> +		BTF_MEMBER_ENC(15, 1, 0), /* int val; */
> +		/* struct val */                                /* [3] */
> +		BTF_TYPE_ENC(15, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 8),
> +		BTF_MEMBER_ENC(19, 1, 0), /* int cnt; */
> +		BTF_MEMBER_ENC(23, 2, 32),/* struct bpf_spin_lock l; */
> +	};
> +	struct btf_header btf_hdr = {
> +		.magic = BTF_MAGIC,
> +		.version = BTF_VERSION,
> +		.hdr_len = sizeof(struct btf_header),
> +		.type_len = sizeof(btf_raw_types),
> +		.str_off = sizeof(btf_raw_types),
> +		.str_len = sizeof(btf_str_sec),
> +	};
> +	__u8 raw_btf[sizeof(struct btf_header) + sizeof(btf_raw_types) +
> +		     sizeof(btf_str_sec)];
> +
> +	memcpy(raw_btf, &btf_hdr, sizeof(btf_hdr));
> +	memcpy(raw_btf + sizeof(btf_hdr), btf_raw_types, sizeof(btf_raw_types));
> +	memcpy(raw_btf + sizeof(btf_hdr) + sizeof(btf_raw_types),
> +	       btf_str_sec, sizeof(btf_str_sec));
> +
> +	return bpf_load_btf(raw_btf, sizeof(raw_btf), 0, 0, 0);
> +}
> +
> +static int create_sk_storage_map(void)
> +{
> +	int btf_fd, map_fd;
> +
> +	btf_fd = load_btf();
> +	CHECK(btf_fd == -1, "bpf_load_btf", "btf_fd:%d errno:%d\n",
> +	      btf_fd, errno);
> +	xattr.btf_fd = btf_fd;
> +
> +	map_fd = bpf_create_map_xattr(&xattr);
> +	xattr.btf_fd = -1;
> +	close(btf_fd);
> +	CHECK(map_fd == -1,
> +	      "bpf_create_map_xattr()", "errno:%d\n", errno);
> +
> +	return map_fd;
> +}
> +
> +static void *insert_close_thread(void *arg)
> +{
> +	struct {
> +		int cnt;
> +		int lock;
> +	} value = { .cnt = 0xeB9F, .lock = 0, };
> +	int i, map_fd, err, *sk_fds;
> +
> +	sk_fds = malloc(sizeof(*sk_fds) * nr_sk_per_thread);
> +	if (!sk_fds) {
> +		notify_thread_err();
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	for (i = 0; i < nr_sk_per_thread; i++)
> +		sk_fds[i] = -1;
> +
> +	while (!is_stopped()) {
> +		if (!wait_for_map())
> +			goto close_all;
> +
> +		map_fd = READ_ONCE(sk_storage_map);
> +		for (i = 0; i < nr_sk_per_thread && !is_stopped(); i++) {
> +			sk_fds[i] = socket(AF_INET6, SOCK_STREAM, 0);
> +			if (sk_fds[i] == -1) {
> +				err = -errno;
> +				fprintf(stderr, "socket(): errno:%d\n", errno);
> +				goto errout;
> +			}
> +			err = bpf_map_update_elem(map_fd, &sk_fds[i], &value,
> +						  BPF_NOEXIST);
> +			if (err) {
> +				err = -errno;
> +				fprintf(stderr,
> +					"bpf_map_update_elem(): errno:%d\n",
> +					errno);
> +				goto errout;
> +			}
> +		}
> +
> +		notify_thread_done();
> +		wait_for_map_close();
> +
> +close_all:
> +		for (i = 0; i < nr_sk_per_thread; i++) {
> +			close(sk_fds[i]);
> +			sk_fds[i] = -1;
> +		}
> +
> +		notify_thread_redo();
> +	}
> +
> +	free(sk_fds);
> +	return NULL;
> +
> +errout:
> +	for (i = 0; i < nr_sk_per_thread && sk_fds[i] != -1; i++)
> +		close(sk_fds[i]);
> +	free(sk_fds);
> +	notify_thread_err();
> +	return ERR_PTR(err);
> +}
> +
> +static int do_sk_storage_map_stress_free(void)
> +{
> +	int i, map_fd = -1, err = 0, nr_threads_created = 0;
> +	pthread_t *sk_thread_ids;
> +	void *thread_ret;
> +
> +	sk_thread_ids = malloc(sizeof(pthread_t) * nr_sk_threads);
> +	if (!sk_thread_ids) {
> +		fprintf(stderr, "malloc(sk_threads): NULL\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < nr_sk_threads; i++) {
> +		err = pthread_create(&sk_thread_ids[i], NULL,
> +				     insert_close_thread, NULL);
> +		if (err) {
> +			err = -errno;
> +			goto done;
> +		}
> +		nr_threads_created++;
> +	}
> +
> +	while (!is_stopped()) {
> +		map_fd = create_sk_storage_map();
> +		WRITE_ONCE(sk_storage_map, map_fd);
> +
> +		if (!wait_for_threads_done())
> +			break;
> +
> +		WRITE_ONCE(sk_storage_map, -1);
> +		close(map_fd);
> +		map_fd = -1;
> +
> +		if (!wait_for_threads_redo())
> +			break;
> +	}
> +
> +done:
> +	WRITE_ONCE(stop, 1);
> +	for (i = 0; i < nr_threads_created; i++) {
> +		pthread_join(sk_thread_ids[i], &thread_ret);
> +		if (IS_ERR(thread_ret) && !err) {
> +			err = PTR_ERR(thread_ret);
> +			fprintf(stderr, "threads#%u: err:%d\n", i, err);
> +		}
> +	}
> +	free(sk_thread_ids);
> +
> +	if (map_fd != -1)
> +		close(map_fd);
> +
> +	return err;
> +}
> +
> +static void *update_thread(void *arg)
> +{
> +	struct {
> +		int cnt;
> +		int lock;
> +	} value = { .cnt = 0xeB9F, .lock = 0, };
> +	int map_fd = READ_ONCE(sk_storage_map);
> +	int sk_fd = *(int *)arg;
> +	int err = 0; /* Suppress compiler false alarm */
> +
> +	while (!is_stopped()) {
> +		err = bpf_map_update_elem(map_fd, &sk_fd, &value, 0);
> +		if (err && errno != EAGAIN) {
> +			err = -errno;
> +			fprintf(stderr, "bpf_map_update_elem: %d %d\n",
> +				err, errno);
> +			break;
> +		}
> +	}
> +
> +	if (!is_stopped()) {
> +		notify_thread_err();
> +		return ERR_PTR(err);
> +	}
> +
> +	return NULL;
> +}
> +
> +static void *delete_thread(void *arg)
> +{
> +	int map_fd = READ_ONCE(sk_storage_map);
> +	int sk_fd = *(int *)arg;
> +	int err = 0; /* Suppress compiler false alarm */
> +
> +	while (!is_stopped()) {
> +		err = bpf_map_delete_elem(map_fd, &sk_fd);
> +		if (err && errno != ENOENT) {
> +			err = -errno;
> +			fprintf(stderr, "bpf_map_delete_elem: %d %d\n",
> +				err, errno);
> +			break;
> +		}
> +	}
> +
> +	if (!is_stopped()) {
> +		notify_thread_err();
> +		return ERR_PTR(err);
> +	}
> +
> +	return NULL;
> +}
> +
> +static int do_sk_storage_map_stress_change(void)
> +{
> +	int i, sk_fd, map_fd = -1, err = 0, nr_threads_created = 0;
> +	pthread_t *sk_thread_ids;
> +	void *thread_ret;
> +
> +	sk_thread_ids = malloc(sizeof(pthread_t) * nr_sk_threads);
> +	if (!sk_thread_ids) {
> +		fprintf(stderr, "malloc(sk_threads): NULL\n");
> +		return -ENOMEM;
> +	}
> +
> +	sk_fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (sk_fd == -1) {
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	map_fd = create_sk_storage_map();
> +	WRITE_ONCE(sk_storage_map, map_fd);
> +
> +	for (i = 0; i < nr_sk_threads; i++) {
> +		if (i & 0x1)
> +			err = pthread_create(&sk_thread_ids[i], NULL,
> +					     update_thread, &sk_fd);
> +		else
> +			err = pthread_create(&sk_thread_ids[i], NULL,
> +					     delete_thread, &sk_fd);
> +		if (err) {
> +			err = -errno;
> +			goto done;
> +		}
> +		nr_threads_created++;
> +	}
> +
> +	wait_for_threads_err();
> +
> +done:
> +	WRITE_ONCE(stop, 1);
> +	for (i = 0; i < nr_threads_created; i++) {
> +		pthread_join(sk_thread_ids[i], &thread_ret);
> +		if (IS_ERR(thread_ret) && !err) {
> +			err = PTR_ERR(thread_ret);
> +			fprintf(stderr, "threads#%u: err:%d\n", i, err);
> +		}
> +	}
> +	free(sk_thread_ids);
> +
> +	if (sk_fd != -1)
> +		close(sk_fd);
> +	close(map_fd);
> +
> +	return err;
> +}
> +
> +static void stop_handler(int signum)
> +{
> +	if (signum != SIGALRM)
> +		printf("stopping...\n");
> +	WRITE_ONCE(stop, 1);
> +}
> +
> +#define BPF_SK_STORAGE_MAP_TEST_NR_THREADS "BPF_SK_STORAGE_MAP_TEST_NR_THREADS"
> +#define BPF_SK_STORAGE_MAP_TEST_SK_PER_THREAD "BPF_SK_STORAGE_MAP_TEST_SK_PER_THREAD"
> +#define BPF_SK_STORAGE_MAP_TEST_RUNTIME_S "BPF_SK_STORAGE_MAP_TEST_RUNTIME_S"
> +#define BPF_SK_STORAGE_MAP_TEST_NAME "BPF_SK_STORAGE_MAP_TEST_NAME"
> +
> +static void test_sk_storage_map_stress_free(void)
> +{
> +	struct rlimit rlim_old, rlim_new = {};
> +	const char *env_opt;
> +	int err;
> +
> +	getrlimit(RLIMIT_NOFILE, &rlim_old);
> +
> +	env_opt = getenv(BPF_SK_STORAGE_MAP_TEST_NR_THREADS);
> +	if (env_opt)
> +		nr_sk_threads = atoi(env_opt);
> +
> +	env_opt = getenv(BPF_SK_STORAGE_MAP_TEST_SK_PER_THREAD);
> +	if (env_opt)
> +		nr_sk_per_thread = atoi(env_opt);
> +
> +	env_opt = getenv(BPF_SK_STORAGE_MAP_TEST_RUNTIME_S);
> +	if (env_opt)
> +		runtime_s = atoi(env_opt);
> +
> +	signal(SIGTERM, stop_handler);
> +	signal(SIGINT, stop_handler);
> +	if (runtime_s > 0) {
> +		signal(SIGALRM, stop_handler);
> +		alarm(runtime_s);
> +	}
> +
> +	if (rlim_old.rlim_cur < nr_sk_threads * nr_sk_per_thread) {
> +		rlim_new.rlim_cur = nr_sk_threads * nr_sk_per_thread + 128;
> +		rlim_new.rlim_max = rlim_new.rlim_cur + 128;
> +		err = setrlimit(RLIMIT_NOFILE, &rlim_new);
> +		CHECK(err, "setrlimit(RLIMIT_NOFILE)", "rlim_new:%lu errno:%d",
> +		      rlim_new.rlim_cur, errno);
> +	}
> +
> +	err = do_sk_storage_map_stress_free();
> +
> +	signal(SIGTERM, SIG_DFL);
> +	signal(SIGINT, SIG_DFL);
> +	if (runtime_s > 0) {
> +		signal(SIGALRM, SIG_DFL);
> +		alarm(0);
> +	}
> +
> +	if (rlim_new.rlim_cur)
> +		setrlimit(RLIMIT_NOFILE, &rlim_old);
> +
> +	CHECK(err, "test_sk_storage_map_stress_free", "err:%d\n", err);
> +}
> +
> +static void test_sk_storage_map_stress_change(void)
> +{
> +	const char *env_opt;
> +	int err;
> +
> +	env_opt = getenv(BPF_SK_STORAGE_MAP_TEST_NR_THREADS);
> +	if (env_opt)
> +		nr_sk_threads = atoi(env_opt);
> +
> +	env_opt = getenv(BPF_SK_STORAGE_MAP_TEST_RUNTIME_S);
> +	if (env_opt)
> +		runtime_s = atoi(env_opt);
> +
> +	signal(SIGTERM, stop_handler);
> +	signal(SIGINT, stop_handler);
> +	if (runtime_s > 0) {
> +		signal(SIGALRM, stop_handler);
> +		alarm(runtime_s);
> +	}
> +
> +	err = do_sk_storage_map_stress_change();
> +
> +	signal(SIGTERM, SIG_DFL);
> +	signal(SIGINT, SIG_DFL);
> +	if (runtime_s > 0) {
> +		signal(SIGALRM, SIG_DFL);
> +		alarm(0);
> +	}
> +
> +	CHECK(err, "test_sk_storage_map_stress_change", "err:%d\n", err);
> +}
> +
> +static void test_sk_storage_map_basic(void)
> +{
> +	struct {
> +		int cnt;
> +		int lock;
> +	} value = { .cnt = 0xeB9f, .lock = 0, }, lookup_value;
> +	struct bpf_create_map_attr bad_xattr;
> +	int btf_fd, map_fd, sk_fd, err;
> +
> +	btf_fd = load_btf();
> +	CHECK(btf_fd == -1, "bpf_load_btf", "btf_fd:%d errno:%d\n",
> +	      btf_fd, errno);
> +	xattr.btf_fd = btf_fd;
> +
> +	sk_fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	CHECK(sk_fd == -1, "socket()", "sk_fd:%d errno:%d\n",
> +	      sk_fd, errno);
> +
> +	map_fd = bpf_create_map_xattr(&xattr);
> +	CHECK(map_fd == -1, "bpf_create_map_xattr(good_xattr)",
> +	      "map_fd:%d errno:%d\n", map_fd, errno);
> +
> +	/* Add new elem */
> +	memcpy(&lookup_value, &value, sizeof(value));
> +	err = bpf_map_update_elem(map_fd, &sk_fd, &value,
> +				  BPF_NOEXIST | BPF_F_LOCK);
> +	CHECK(err, "bpf_map_update_elem(BPF_NOEXIST|BPF_F_LOCK)",
> +	      "err:%d errno:%d\n", err, errno);
> +	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> +					BPF_F_LOCK);
> +	CHECK(err || lookup_value.cnt != value.cnt,
> +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> +	      "err:%d errno:%d cnt:%x(%x)\n",
> +	      err, errno, lookup_value.cnt, value.cnt);
> +
> +	/* Bump the cnt and update with BPF_EXIST | BPF_F_LOCK */
> +	value.cnt += 1;
> +	err = bpf_map_update_elem(map_fd, &sk_fd, &value,
> +				  BPF_EXIST | BPF_F_LOCK);
> +	CHECK(err, "bpf_map_update_elem(BPF_EXIST|BPF_F_LOCK)",
> +	      "err:%d errno:%d\n", err, errno);
> +	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> +					BPF_F_LOCK);
> +	CHECK(err || lookup_value.cnt != value.cnt,
> +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> +	      "err:%d errno:%d cnt:%x(%x)\n",
> +	      err, errno, lookup_value.cnt, value.cnt);
> +
> +	/* Bump the cnt and update with BPF_EXIST */
> +	value.cnt += 1;
> +	err = bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_EXIST);
> +	CHECK(err, "bpf_map_update_elem(BPF_EXIST)",
> +	      "err:%d errno:%d\n", err, errno);
> +	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> +					BPF_F_LOCK);
> +	CHECK(err || lookup_value.cnt != value.cnt,
> +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> +	      "err:%d errno:%d cnt:%x(%x)\n",
> +	      err, errno, lookup_value.cnt, value.cnt);
> +
> +	/* Update with BPF_NOEXIST */
> +	value.cnt += 1;
> +	err = bpf_map_update_elem(map_fd, &sk_fd, &value,
> +				  BPF_NOEXIST | BPF_F_LOCK);
> +	CHECK(!err || errno != EEXIST,
> +	      "bpf_map_update_elem(BPF_NOEXIST|BPF_F_LOCK)",
> +	      "err:%d errno:%d\n", err, errno);
> +	err = bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_NOEXIST);
> +	CHECK(!err || errno != EEXIST, "bpf_map_update_elem(BPF_NOEXIST)",
> +	      "err:%d errno:%d\n", err, errno);
> +	value.cnt -= 1;
> +	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> +					BPF_F_LOCK);
> +	CHECK(err || lookup_value.cnt != value.cnt,
> +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> +	      "err:%d errno:%d cnt:%x(%x)\n",
> +	      err, errno, lookup_value.cnt, value.cnt);
> +
> +	/* Bump the cnt again and update with map_flags == 0 */
> +	value.cnt += 1;
> +	err = bpf_map_update_elem(map_fd, &sk_fd, &value, 0);
> +	CHECK(err, "bpf_map_update_elem()", "err:%d errno:%d\n",
> +	      err, errno);
> +	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> +					BPF_F_LOCK);
> +	CHECK(err || lookup_value.cnt != value.cnt,
> +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> +	      "err:%d errno:%d cnt:%x(%x)\n",
> +	      err, errno, lookup_value.cnt, value.cnt);
> +
> +	/* Test delete elem */
> +	err = bpf_map_delete_elem(map_fd, &sk_fd);
> +	CHECK(err, "bpf_map_delete_elem()", "err:%d errno:%d\n",
> +	      err, errno);
> +	err = bpf_map_lookup_elem_flags(map_fd, &sk_fd, &lookup_value,
> +					BPF_F_LOCK);
> +	CHECK(!err || errno != ENOENT,
> +	      "bpf_map_lookup_elem_flags(BPF_F_LOCK)",
> +	      "err:%d errno:%d\n", err, errno);
> +	err = bpf_map_delete_elem(map_fd, &sk_fd);
> +	CHECK(!err || errno != ENOENT, "bpf_map_delete_elem()",
> +	      "err:%d errno:%d\n", err, errno);
> +
> +	memcpy(&bad_xattr, &xattr, sizeof(xattr));
> +	bad_xattr.btf_key_type_id = 0;
> +	err = bpf_create_map_xattr(&bad_xattr);
> +	CHECK(!err || errno != EINVAL, "bap_create_map_xattr(bad_xattr)",
> +	      "err:%d errno:%d\n", err, errno);
> +
> +	memcpy(&bad_xattr, &xattr, sizeof(xattr));
> +	bad_xattr.btf_key_type_id = 3;
> +	err = bpf_create_map_xattr(&bad_xattr);
> +	CHECK(!err || errno != EINVAL, "bap_create_map_xattr(bad_xattr)",
> +	      "err:%d errno:%d\n", err, errno);
> +
> +	memcpy(&bad_xattr, &xattr, sizeof(xattr));
> +	bad_xattr.max_entries = 1;
> +	err = bpf_create_map_xattr(&bad_xattr);
> +	CHECK(!err || errno != EINVAL, "bap_create_map_xattr(bad_xattr)",
> +	      "err:%d errno:%d\n", err, errno);
> +
> +	memcpy(&bad_xattr, &xattr, sizeof(xattr));
> +	bad_xattr.map_flags = 0;
> +	err = bpf_create_map_xattr(&bad_xattr);
> +	CHECK(!err || errno != EINVAL, "bap_create_map_xattr(bad_xattr)",
> +	      "err:%d errno:%d\n", err, errno);
> +
> +	xattr.btf_fd = -1;
> +	close(btf_fd);
> +	close(map_fd);
> +	close(sk_fd);
> +}
> +
> +void test_sk_storage_map(void)
> +{
> +	const char *test_name;
> +
> +	test_name = getenv(BPF_SK_STORAGE_MAP_TEST_NAME);
> +
> +	if (!test_name || !strcmp(test_name, "basic"))
> +		test_sk_storage_map_basic();
> +	if (!test_name || !strcmp(test_name, "stress_free"))
> +		test_sk_storage_map_stress_free();
> +	if (!test_name || !strcmp(test_name, "stress_change"))
> +		test_sk_storage_map_stress_change();
> +}
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 3c627771f965..246f745cb006 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -27,6 +27,7 @@
>  
>  #include "bpf_util.h"
>  #include "bpf_rlimit.h"
> +#include "test_maps.h"
>  
>  #ifndef ENOTSUPP
>  #define ENOTSUPP 524
> @@ -36,15 +37,6 @@ static int skips;
>  
>  static int map_flags;
>  
> -#define CHECK(condition, tag, format...) ({				\
> -	int __ret = !!(condition);					\
> -	if (__ret) {							\
> -		printf("%s(%d):FAIL:%s ", __func__, __LINE__, tag);	\
> -		printf(format);						\
> -		exit(-1);						\
> -	}								\
> -})
> -
>  static void test_hashmap(unsigned int task, void *data)
>  {
>  	long long key, next_key, first_key, value;
> @@ -1703,6 +1695,10 @@ static void run_all_tests(void)
>  	test_map_in_map();
>  }
>  
> +#define DECLARE
> +#include <map_tests/tests.h>
> +#undef DECLARE
> +
>  int main(void)
>  {
>  	srand(time(NULL));
> @@ -1713,6 +1709,10 @@ int main(void)
>  	map_flags = BPF_F_NO_PREALLOC;
>  	run_all_tests();
>  
> +#define CALL
> +#include <map_tests/tests.h>
> +#undef CALL
> +
>  	printf("test_maps: OK, %d SKIPPED\n", skips);
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/test_maps.h b/tools/testing/selftests/bpf/test_maps.h
> new file mode 100644
> index 000000000000..77d8587ac4ed
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_maps.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TEST_MAPS_H
> +#define _TEST_MAPS_H
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#define CHECK(condition, tag, format...) ({				\
> +	int __ret = !!(condition);					\
> +	if (__ret) {							\
> +		printf("%s(%d):FAIL:%s ", __func__, __LINE__, tag);	\
> +		printf(format);						\
> +		exit(-1);						\
> +	}								\
> +})
> +
> +#endif
> -- 
> 2.17.1
> 
