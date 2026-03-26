Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97F423154
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546434; cv=pass; b=uNKAQ23zVbks5PrWptQLAeAfiD5EFSupvy/x2SqkRQ0DjhKT2597sDydVK4OpN23DavlQvV400ntA8uVZOKlX+cQgb6cLEw/+m1bk5gF1jhmCUcku6B+oTMSH65TNTEokusGrUsavf51e9TUFOnqEvppGzGGGZV2+ppcWB9v3Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546434; c=relaxed/simple;
	bh=enIR8hn0lGh5urCvp0sBzvHWDNRFkxHFSP3DvhwRZr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufjdhFMI7fCUEwQ9+cKSCSQEbvcQ4jSKFcY+kreiRTWTaZqjyNGu8H7kH7z1Q/viiDjoJoSFsJGgS2XJzBkbJ9Sdj5ckwT69xolL9oDfEyxEiYOcaKj6DioUnumhj1+G18ZebLAa9oZkyzVjwSI5r3TAsV+Ag0nUeWhpU1TolLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9MnzqE5; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9MnzqE5"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128e4d0cc48so1576334c88.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774546431; cv=none;
        d=google.com; s=arc-20240605;
        b=L+yGVK1hrM5PiJRtBv20wEFHVBZCDaArzRpm8UZ4NkwwxrGNAgNSo2rMdRf944ZGmY
         fJqPXybPBN7LkPASCtNE7rY2C9U7Q+DysNb/C4wEbJWkvQgIQcsMcSZpFajU8+Xv+q0Q
         3DQX70RDOljx936QfR8rmLPvvGa5ZnAoYf3kPQFdTiPpJHgE6l4L5U630PObC+lJaHrh
         IBIenYAjcwoTqU1iKaIYB1vkWwHQFePmBnuenTIRC1O8Gyu48JnC/XLGp2EvFgHNiHE7
         j3HjxkNrNuPehBFEyNSrTo5+vEGtGMFAL8wizNFcqsQjjcG11JUyOcnAkJr/Lk/bOw7C
         LaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UBlbyIdCNBEMI5MiB4eQOKODfC+ZCUFx/Clh1SgBkSc=;
        fh=UYH1nnhW+kXDuixK8I1S+GTTmtgi33oj0mwjMKjhkA4=;
        b=B3BzBu7ZZrPqf9y8VTb67uiSVuL0FvCv1dUKbI8KwVRmjc7wgw4dMdglcP2/K6tZ5o
         r3nZ1XZgytkMrpYv9V1/9GOojSkP63+nvQXRZABYgDfOTvrNblT42/87cDyWZIfZFHOK
         huovI3WPt3MEWIOTHAb1sOUe2dkEZh62IRGBBptBInjg7hPFSMATg3gQiQJKFfyiZYwe
         VmGbx4koKZL3Y34ATvb/iREiIRuEa6uG7oJgV2CTa8+/mZGyrxEqXew9KWeRUuBM8UHW
         huWS+2Ml64mTJYa8Tvfaz1tJ5Tc0h/RvN6rvthYnUFqdcccZ/ouYrq5VUCCiWBlWP6R5
         kqYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774546431; x=1775151231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBlbyIdCNBEMI5MiB4eQOKODfC+ZCUFx/Clh1SgBkSc=;
        b=v9MnzqE5YJGSnT7br/Zv+Fxx6l1BdoHZyk8LKc5ZBuyMk8dwPUMP2owMvvlJwDwOjX
         QY7eWIbbW76V0ed6fnlT9KibT+0r12tem9fvYXxNblzWx5XTpgqrC/SJVUUlVAYrGldL
         AG9OcmM0KYCBb51+k4kCBjO/gcnknfnD0PNIHvQ4aERdVsHxBxOVZ91LXJzLt36KJtfy
         TPjGplb58TWu1JuqmgAUGLPWvKbW79LKFIWztfIDkOhe0j5GUv7EgDyg5JtUsTpKRuNz
         DG+X53cnXqR0mT77d5XciVbG95bQG4ttoZZrW5PqoDl4gwqzaCW6aAQvoIE1FWJN+FB8
         lK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546431; x=1775151231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBlbyIdCNBEMI5MiB4eQOKODfC+ZCUFx/Clh1SgBkSc=;
        b=WEnaqiT+zAaUI17VFTnQpWtOM9rbQs7+RDpx7RXnoPI+Mx955zt8lVVhoKu/OLMb3i
         mvI8QXOH2fi80DDsEBQgcBNxDHxPNHyypRXQWmOy6lj2tygI2inZCi0xhNAFdy0yR1X9
         +C2s3nT3XHsXsV//z8986n4Y79NiWLLKZUm7nxmM6aNQ4yjRdZrpd2RPMCkVBLRX01ro
         ZyFmThPTFalGUAbstlO5N8gZbdYcTuNofj17vRSJtbH6RzTNeV3VaBFhYvU+xh4HhJ8A
         Hsyzron4enYIvZqgUFVEAkhX0gV4lok4zzOhrW2aVFrEUuT6X7H/1gKiXXjOPTK4gACf
         Io2g==
X-Forwarded-Encrypted: i=1; AJvYcCV8bj4r83R2I7fza+cjuH+WC9WiwYdo2U9xa80teSR1X6Qh6mACIhpGDLN01Hh3zr4RDsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdta1jU0BI42QVAKORiKubwv5NTC4QcmRbAbCwjMcoiKW6deh
	rdC7zWcvWjNNdDvUQRpy4Lxcs6UbBMCJ2GmXOuJw8CQ1g3mCBj/HEGozlc6fYCbtF8QSNMLnT7O
	mUgc/G9DOUVhgdch6agrmMgnuMWR8Eu5K/SycGU5U
X-Gm-Gg: ATEYQzwsFyyRM1va9Xgst3JKkp8kdDdPnlQPnJtVT331jyTNFoD6YlY9X0qj7d4dWj9
	GU4d6cPVuAJ6wXs4NomPx0it0kYfWCgxhgxnyKnwgoENp+pKUFK33HhF00X6MwHXruFu6dLlgLV
	DZDPUWCKJ1KD6/dBPuVoQNxkE622uw+EAzdzv9DZ43hFx3FBKHnuVA+ZUdkb6BXu6+hq12LLLk+
	r37IYldTfqMrQ1DJds0KUm/fSDeyXijIR4Y9/7PWseiCiKXdaQ/Evpi879Dwtxst9uMjif5VvxI
	1/m+z6rKwFiKFqUy4N59cwLm4JtHzNrA98/sCTTIzfkHalNiuqxUbhHbq/Fqj4rgDi591w==
X-Received: by 2002:a05:7022:510:b0:128:c77a:6c8e with SMTP id
 a92af1059eb24-12a96ee761bmr4396564c88.28.1774546430167; Thu, 26 Mar 2026
 10:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326062657.88446-1-jiayuan.chen@linux.dev> <20260326062657.88446-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260326062657.88446-3-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Mar 2026 10:33:38 -0700
X-Gm-Features: AQROBzDQ517miMG9UXLHYmpX05dz7v3KwflXAHCbFO1GCpDNoBoxWfF4Zv9vwmM
Message-ID: <CAAVpQUAKAeU8SXpKQwcQS6P6aFJ_BxmevcrK=Hs+_rf_mnaLXA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 11:27=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> Add test_tcp_custom_syncookie_protocol_check to verify that
> bpf_sk_assign_tcp_reqsk() rejects non-TCP skbs. The test sends a UDP
> packet through TC ingress where a BPF program calls
> bpf_sk_assign_tcp_reqsk() on it and checks that the kfunc returns an
> error. A UDP server recv() is used as synchronization to ensure the
> BPF program has finished processing before checking the result.
>
> Without the fix in bpf_sk_assign_tcp_reqsk(), the kfunc succeeds and
> attaches a TCP reqsk to the UDP skb, which causes a null pointer
> dereference panic when the kernel processes it through the UDP receive
> path.
>
> Test result:
>
>   ./test_progs -a tcp_custom_syncookie_protocol_check -v
>   setup_netns:PASS:create netns 0 nsec
>   setup_netns:PASS:ip 0 nsec
>   write_sysctl:PASS:open sysctl 0 nsec
>   write_sysctl:PASS:write sysctl 0 nsec
>   setup_netns:PASS:write_sysctl 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:open_and_load 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:start tcp_server 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:start udp_server 0 nsec
>   setup_tc:PASS:qdisc add dev lo clsact 0 nsec
>   setup_tc:PASS:filter add dev lo ingress 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:udp socket 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:sendto udp 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:recv udp 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:udp_intercepted 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:assign_ret 0 nsec
>   #471     tcp_custom_syncookie_protocol_check:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 84 ++++++++++++++++++-
>  .../bpf/progs/test_tcp_custom_syncookie.c     | 79 +++++++++++++++++
>  2 files changed, 159 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> index eaf441dc7e79..c50b76f70988 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> @@ -5,6 +5,7 @@
>  #include <sched.h>
>  #include <stdlib.h>
>  #include <net/if.h>
> +#include <netinet/in.h>
>
>  #include "test_progs.h"
>  #include "cgroup_helpers.h"
> @@ -47,11 +48,10 @@ static int setup_netns(void)
>         return -1;
>  }
>
> -static int setup_tc(struct test_tcp_custom_syncookie *skel)
> +static int setup_tc(int prog_fd)
>  {
>         LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point =3D BPF_TC_INGRE=
SS);
> -       LIBBPF_OPTS(bpf_tc_opts, tc_attach,
> -                   .prog_fd =3D bpf_program__fd(skel->progs.tcp_custom_s=
yncookie));
> +       LIBBPF_OPTS(bpf_tc_opts, tc_attach, .prog_fd =3D prog_fd);
>
>         qdisc_lo.ifindex =3D if_nametoindex("lo");
>         if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo c=
lsact"))
> @@ -127,7 +127,7 @@ void test_tcp_custom_syncookie(void)
>         if (!ASSERT_OK_PTR(skel, "open_and_load"))
>                 return;
>
> -       if (setup_tc(skel))
> +       if (setup_tc(bpf_program__fd(skel->progs.tcp_custom_syncookie)))
>                 goto destroy_skel;
>
>         for (i =3D 0; i < ARRAY_SIZE(test_cases); i++) {
> @@ -145,6 +145,82 @@ void test_tcp_custom_syncookie(void)
>
>  destroy_skel:
>         system("tc qdisc del dev lo clsact");
> +       test_tcp_custom_syncookie__destroy(skel);
> +}
>
> +/* Test: bpf_sk_assign_tcp_reqsk() should reject non-TCP skb.
> + *
> + * Send a UDP packet through TC ingress where a BPF program calls
> + * bpf_sk_assign_tcp_reqsk() on it. The kfunc should return an error
> + * because the skb carries UDP, not TCP.
> + */
> +void test_tcp_custom_syncookie_protocol_check(void)
> +{
> +       int tcp_server =3D -1, udp_server =3D -1, udp_client =3D -1;
> +       struct test_tcp_custom_syncookie *skel;
> +       struct sockaddr_in udp_addr;
> +       char buf[32] =3D "test";
> +       int udp_port, ret;
> +
> +       if (setup_netns())
> +               return;
> +
> +       skel =3D test_tcp_custom_syncookie__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +               return;
> +
> +       /* Create a TCP listener so the BPF can find a LISTEN socket */
> +       tcp_server =3D start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,=
 0);

Can you add IPv6 test as well ?
You can reuse test_tcp_custom_syncookie_case[].


> +       if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
> +               goto destroy_skel;
> +
> +       /* Create a UDP server to receive the packet as synchronization *=
/
> +       udp_server =3D start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, =
0);

You can specify the port to get_socket_local_port(tcp_server),


> +       if (!ASSERT_NEQ(udp_server, -1, "start udp_server"))
> +               goto close_tcp;
> +
> +       skel->bss->tcp_listener_port =3D ntohs(get_socket_local_port(tcp_=
server));
> +       udp_port =3D ntohs(get_socket_local_port(udp_server));
> +       skel->bss->udp_test_port =3D udp_port;

then the 3 lines above will be unnecessary,


> +
> +       ret =3D bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto=
);
> +       if (setup_tc(ret))
> +               goto close_udp_server;
> +
> +       udp_client =3D socket(AF_INET, SOCK_DGRAM, 0);
> +       if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
> +               goto cleanup_tc;
> +
> +       memset(&udp_addr, 0, sizeof(udp_addr));
> +       udp_addr.sin_family =3D AF_INET;
> +       udp_addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> +       udp_addr.sin_port =3D htons(udp_port);

and you can reuse get_socket_local_port(tcp_server) here too.


> +
> +       ret =3D sendto(udp_client, buf, sizeof(buf), 0,
> +                    (struct sockaddr *)&udp_addr, sizeof(udp_addr));
> +       if (!ASSERT_EQ(ret, sizeof(buf), "sendto udp"))
> +               goto cleanup_tc;
> +
> +       /* recv() ensures TC ingress BPF has processed the skb */
> +       ret =3D recv(udp_server, buf, sizeof(buf), 0);
> +       if (!ASSERT_EQ(ret, sizeof(buf), "recv udp"))
> +               goto cleanup_tc;
> +
> +       ASSERT_EQ(skel->bss->udp_intercepted, true, "udp_intercepted");
> +
> +       /* assign_ret =3D=3D 0 means kfunc accepted UDP skb (bug).
> +        * assign_ret < 0 means kfunc correctly rejected it (fixed).
> +        */
> +       ASSERT_NEQ(skel->data->assign_ret, 0, "assign_ret");
> +
> +cleanup_tc:
> +       system("tc qdisc del dev lo clsact");
> +       if (udp_client >=3D 0)
> +               close(udp_client);
> +close_udp_server:
> +       close(udp_server);
> +close_tcp:
> +       close(tcp_server);
> +destroy_skel:
>         test_tcp_custom_syncookie__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> index 7d5293de1952..386705b6c9f2 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> @@ -588,4 +588,83 @@ int tcp_custom_syncookie(struct __sk_buff *skb)
>         return tcp_handle_ack(&ctx);
>  }
>
> +/* Test: call bpf_sk_assign_tcp_reqsk() on a UDP skb.
> + * The kfunc should reject it, but currently it doesn't check L4 protoco=
l.
> + */
> +__u16 tcp_listener_port =3D 0;
> +__u16 udp_test_port =3D 0;
> +int assign_ret =3D -1;
> +bool udp_intercepted =3D false;
> +
> +SEC("tc")
> +int tcp_custom_syncookie_badproto(struct __sk_buff *skb)
> +{
> +       void *data =3D (void *)(long)skb->data;
> +       void *data_end =3D (void *)(long)skb->data_end;
> +       struct bpf_sock_tuple tuple =3D {};
> +       struct bpf_tcp_req_attrs attrs =3D {};
> +       struct ethhdr *eth;
> +       struct iphdr *iph;
> +       struct udphdr *udp;
> +       struct bpf_sock *skc;
> +       struct sock *sk;
> +
> +       eth =3D (struct ethhdr *)data;
> +       if (eth + 1 > data_end)
> +               return TC_ACT_OK;
> +
> +       if (bpf_ntohs(eth->h_proto) !=3D ETH_P_IP)
> +               return TC_ACT_OK;
> +
> +       iph =3D (struct iphdr *)(eth + 1);
> +       if (iph + 1 > data_end)
> +               return TC_ACT_OK;
> +
> +       if (iph->protocol !=3D IPPROTO_UDP)
> +               return TC_ACT_OK;
> +
> +       udp =3D (struct udphdr *)(iph + 1);
> +       if (udp + 1 > data_end)
> +               return TC_ACT_OK;
> +
> +       if (bpf_ntohs(udp->dest) !=3D udp_test_port)
> +               return TC_ACT_OK;

You don't need to worry about other program sending UDP
packets in this netns created by unshare().


> +
> +       udp_intercepted =3D true;
> +
> +       tuple.ipv4.saddr =3D iph->saddr;
> +       tuple.ipv4.daddr =3D iph->daddr;
> +       tuple.ipv4.sport =3D udp->source;
> +       tuple.ipv4.dport =3D bpf_htons(tcp_listener_port);

and you can simply reuse dport here too.


> +
> +       skc =3D bpf_skc_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), -1, 0=
);
> +       if (!skc)
> +               return TC_ACT_OK;
> +
> +       if (skc->state !=3D TCP_LISTEN) {
> +               bpf_sk_release(skc);
> +               return TC_ACT_OK;
> +       }
> +
> +       sk =3D (struct sock *)bpf_skc_to_tcp_sock(skc);
> +       if (!sk) {
> +               bpf_sk_release(skc);
> +               return TC_ACT_OK;
> +       }
> +
> +       attrs.mss =3D 1460;
> +       attrs.wscale_ok =3D 1;
> +       attrs.snd_wscale =3D 7;
> +       attrs.rcv_wscale =3D 7;
> +       attrs.sack_ok =3D 1;
> +
> +       /* Call bpf_sk_assign_tcp_reqsk on a UDP skb. */
> +       assign_ret =3D bpf_sk_assign_tcp_reqsk(skb, sk, &attrs, sizeof(at=
trs));
> +
> +       bpf_sk_release(skc);
> +
> +       /* Let the packet continue into the kernel */
> +       return TC_ACT_OK;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.0
>
