Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7911B4138;
	Thu, 15 Oct 2026 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055066; cv=none; b=o8NuRNoZgAy28lh0SeRXR5H6FcMTEy++CZWGUO/Yb3ANXm+dYOKPOrJ8cIegl6y3DalQeVGMFF92zfzRS9b8bPsYCpHHiCRSiCNlXxyvbvJkul/D+QyD2tGxU/CAmkVeoWdm8CpJfYrvWXJF8yEaBoFlsF/70uIgGVSNAedSGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055066; c=relaxed/simple;
	bh=DaDprXY7JFb4yPV7CsCOjoWG+CIL1Y13WsGq8F4g/Mg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7DTBXBtrFmjwdwG/ByuZkt6jqiqC29ohH0xE4xWs/K1LYaIX1poGAjrabLQwfOMv2qt+7XBjvavdUPzofHHFTCuIE4yIF1qcIpdnulIDzV9gxI7fjHk9eFFVpQBLU2xBmymEBcWN1PjZUwGh9wpkoViC2m3uqaELmtP27gdisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbNi3piy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbNi3piy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540B21F000C4;
	Thu, 15 Oct 2026 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792055064;
	bh=PWX4FwLquBBGsD2hXMU+jP+LFT++TZL0PaDyIMYbcPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NbNi3piyh60+lCl5IjSr7by3mWHVre7iFuahkStTItBoHlt3hHmm9Fu/tB6iB5Ule
	 QrxrdNKlWViWxvifVhOguyBC0clR6hMJEzK8nmo4XHcWNH7mfTnCd1ZuHB7ih6NjEp
	 L88TNmX0a8m9yBZHOsteGg3fthqwTu3ylIeZEkPuKtCy7RBvPlGkDrRcMz9cZVAy7P
	 RHW6HiqFPK0aIVS89wtCRVnrIlb1NWlQu+w/57lruZki0xNrAQ2BdYQPsqnsvwaKyR
	 q/zm5AKgR6ouYWikuCqp8Dz3Ed/AYdUDbGqar1b48gT66SUsg3GC7d0bS4qIsdsOjP
	 Oon/7gXkwhSDw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 10/15] selftests: xsk: run the RX and TX
 endpoints in separate processes
In-Reply-To: <20261014184539.774708-11-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-11-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 11:04:20 +0200
Message-ID: <871p9r72sr.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Run the two endpoints of a test case as separate xskxceiver processes,
> so that a later patch can run them on two hosts. A process binds only
> the interface given with -i, takes its role from -e rx|tx and meets the
> other endpoint over a small TCP control channel (-p HOST -P PORT). The
> other side is represented by a shadow ifobject that mirrors the local
> capabilities and holds a loaded copy of the XDP skeleton, so the shared
> test code keeps addressing both sides while only the local interface is
> programmed. Once BIDIRECTIONAL swaps the directions, the local
> interface runs the shadow's programs.
>
> The pthreads, the barrier, test->fail and -lpthread go away. Each
> process runs the worker of its local ifobject, and the endpoints
> exchange three fixed-size messages:
>
> - READY, exchanged before each step, works as a barrier; TCP ordering
>   puts all progress of the previous step before it
> - PROGRESS carries the number of packets RX consumed, which TX
>   subtracts from its in-flight count so as not to overrun the RX UMEM
> - ABORT tells the other endpoint to stop waiting after a failure
>
> TX listens and RX connects. The listener says on stderr when it
> listens, so the launcher starts the connector then rather than polling
> for the port, which could also find a foreign listener. The listener
> waits 30s for the connector, and -P takes a port number. As with the
> control channels of other selftests, the hosts are trusted and the
> channel is not authenticated. Test selection, interface capabilities
> and verdicts stay with the launcher.
>
> test_xsk.py starts TX on a random control port on 127.0.0.1 and RX
> once TX listens, and kills TX and fails the case when it does not
> listen within 30s. The case passes when both endpoints pass, and is
> skipped when one skips and neither fails. Only the output of an
> endpoint that does not pass is logged, prefixed with its role.
> xsk_wait_listen(), which reads the TX stderr up to the listen line,
> joins the library helpers, and xsk_wait_endpoint_exit() logs that
> output along with the rest.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  tools/testing/selftests/net/lib/Makefile      |   3 +-
>  .../testing/selftests/net/lib/py/__init__.py  |   4 +-
>  tools/testing/selftests/net/lib/py/xsk.py     |  35 ++-
>  .../testing/selftests/net/lib/xsk/test_xsk.c  | 205 +++++++-----
>  .../testing/selftests/net/lib/xsk/test_xsk.h  |  23 +-
>  .../testing/selftests/net/lib/xsk/xsk_peer.c  | 293 ++++++++++++++++++
>  .../testing/selftests/net/lib/xsk/xsk_peer.h  |  19 ++
>  .../selftests/net/lib/xsk/xskxceiver.c        | 136 ++++++--
>  tools/testing/selftests/net/test_xsk.py       |  68 ++--
>  9 files changed, 633 insertions(+), 153 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.c
>  create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.h
>
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/sel=
ftests/net/lib/Makefile
> index 5c1612315062..49dac776202b 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -38,13 +38,12 @@ include ../bpf.mk
>  XSK_DIR :=3D xsk
>  XSK_BPF_OBJ :=3D $(OUTPUT)/xsk_xdp_progs.bpf.o
>  XSK_SKEL :=3D $(OUTPUT)/xsk_xdp_progs.skel.h
> -XSK_SOURCES :=3D $(addprefix $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c) \
> +XSK_SOURCES :=3D $(addprefix $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c x=
sk_peer.c) \
>  	$(top_srcdir)/tools/lib/find_bit.c
>  XSK_HEADERS :=3D $(wildcard $(XSK_DIR)/*.h)
>=20=20
>  PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
>  XSK_LDLIBS :=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo =
-lelf) -lz
> -XSK_LDLIBS +=3D -lpthread
>=20=20
>  $(XSK_BPF_OBJ): $(XSK_DIR)/xsk_xdp_progs.bpf.c $(XSK_DIR)/xsk_xdp_common=
.h $(BPFOBJ)
>  	$(call msg,BPF_PROG,,$@)
> diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testi=
ng/selftests/net/lib/py/__init__.py
> index 1a93ab8b1e60..a82bac8a6b47 100644
> --- a/tools/testing/selftests/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/net/lib/py/__init__.py
> @@ -17,7 +17,7 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd=
, bkg, defer, \
>      ctl_file_write, wait_file, tool, tc
>  from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
>  from .xsk import xsk_reserve_hugepages, xsk_release_hugepages, \
> -    xsk_setup_busy_poll, xsk_wait_endpoint_exit
> +    xsk_setup_busy_poll, xsk_wait_endpoint_exit, xsk_wait_listen
>  from .ynl import NlError, NlctrlFamily, YnlFamily, \
>      EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily, RtnlRouteFa=
mily
>  from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
> @@ -34,7 +34,7 @@ __all__ =3D ["KSRC",
>             "wait_port_listen", "ctl_file_write", "wait_file", "tool", "t=
c",
>             "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
>             "xsk_reserve_hugepages", "xsk_release_hugepages",
> -           "xsk_setup_busy_poll", "xsk_wait_endpoint_exit",
> +           "xsk_setup_busy_poll", "xsk_wait_endpoint_exit", "xsk_wait_li=
sten",
>             "NetdevSim", "NetdevSimDev",
>             "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
>             "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
> diff --git a/tools/testing/selftests/net/lib/py/xsk.py b/tools/testing/se=
lftests/net/lib/py/xsk.py
> index 50985bcb5b80..6f4ffc4786d2 100644
> --- a/tools/testing/selftests/net/lib/py/xsk.py
> +++ b/tools/testing/selftests/net/lib/py/xsk.py
> @@ -5,9 +5,10 @@ Helpers to run xskxceiver, the AF_XDP test program in ne=
t/lib/xsk.
>  """
>=20=20
>  import subprocess
> +import time
>=20=20
>  from .ksft import ksft_pr
> -from .utils import cmd, ctl_file_write
> +from .utils import cmd, ctl_file_write, fd_read_timeout
>=20=20
>  NR_HUGEPAGES =3D 32
>=20=20
> @@ -41,10 +42,32 @@ def xsk_setup_busy_poll(ifname):
>      ctl_file_write(f"{sysfs}/gro_flush_timeout", 200000)
>=20=20
>=20=20
> -def xsk_wait_endpoint_exit(endpoint, label, timeout):
> -    """Wait up to timeout seconds for xskxceiver to exit, kill it if it =
does
> -    not, and return its exit code. Log its output, a KTAP stream of its =
own,
> -    prefixed with label, only if it did not pass."""
> +def xsk_wait_listen(endpoint, port, timeout):
> +    """Wait up to timeout seconds for an xskxceiver endpoint to print on
> +    stderr that it listens on the control port. Unlike polling for the p=
ort,
> +    this never takes a foreign listener for it and costs no SSH login per
> +    try on a remote host. Return the stderr read so far and whether that
> +    line came."""
> +    line =3D f"Listening for XSK peer on port {port}\n".encode()
> +    fd =3D endpoint.proc.stderr.fileno()
> +    head =3D b""
> +    deadline =3D time.monotonic() + timeout
> +    while line not in head:
> +        try:
> +            data =3D fd_read_timeout(fd, max(deadline - time.monotonic()=
, 0))
> +        except TimeoutError:
> +            break
> +        if not data:
> +            break
> +        head +=3D data
> +    return head.decode(), line in head
> +
> +
> +def xsk_wait_endpoint_exit(endpoint, label, timeout, head=3D""):
> +    """Wait up to timeout seconds for an xskxceiver endpoint to exit, ki=
ll it
> +    if it does not, and return its exit code. Log its output, a KTAP str=
eam
> +    of its own, prefixed with label, only if it did not pass. head is the
> +    start of its stderr, if xsk_wait_listen() took it off the pipe."""
>      try:
>          endpoint.process(terminate=3DFalse, fail=3DFalse, timeout=3Dtime=
out)
>      except subprocess.TimeoutExpired:
> @@ -52,7 +75,7 @@ def xsk_wait_endpoint_exit(endpoint, label, timeout):
>          endpoint.process(terminate=3DFalse, fail=3DFalse)
>          ksft_pr(f"killed after {timeout}s", line_pfx=3Df"{label}|")
>      if endpoint.ret:
> -        for out in (endpoint.stdout, endpoint.stderr):
> +        for out in (endpoint.stdout, head + endpoint.stderr):
>              if out:
>                  ksft_pr(out.rstrip(), line_pfx=3Df"{label}|")
>      return endpoint.ret
> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testi=
ng/selftests/net/lib/xsk/test_xsk.c
> index e4e0d4dfab5a..f67a32c0260a 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> @@ -7,7 +7,6 @@
>  #include <linux/mman.h>
>  #include <linux/netdev.h>
>  #include <poll.h>
> -#include <pthread.h>
>  #include <string.h>
>  #include <sys/mman.h>
>  #include <sys/socket.h>
> @@ -15,6 +14,7 @@
>  #include <unistd.h>
>=20=20
>  #include "test_xsk.h"
> +#include "xsk_peer.h"
>  #include "xsk_xdp_common.h"
>  #include "xsk_xdp_progs.skel.h"
>=20=20
> @@ -38,10 +38,37 @@
>  static const u8 g_mac[ETH_ALEN] =3D {0x55, 0x44, 0x33, 0x22, 0x11, 0x00};
>=20=20
>  bool opt_verbose;
> -pthread_barrier_t barr;
> -pthread_mutex_t pacing_mutex =3D PTHREAD_MUTEX_INITIALIZER;
>=20=20
>  int pkts_in_flight;
> +static struct xsk_peer *ctrl_peer;
> +
> +void xsk_set_endpoint(struct xsk_peer *peer)
> +{
> +	ctrl_peer =3D peer;
> +}
> +
> +static int pacing_rx_progress(u32 pkts)
> +{
> +	int err =3D xsk_peer_rx_progress(ctrl_peer, pkts);
> +
> +	if (err)
> +		ksft_print_msg("RX control channel failed: %d (%s)\n", err,
> +			       strerror(-err));
> +	return err;
> +}
> +
> +static int pacing_tx_sync(void)
> +{
> +	int acked =3D xsk_peer_tx_sync(ctrl_peer);
> +
> +	if (acked < 0) {
> +		ksft_print_msg("TX control channel failed: %d (%s)\n", acked,
> +			       strerror(-acked));
> +		return acked;
> +	}
> +	pkts_in_flight -=3D acked;
> +	return 0;
> +}
>=20=20
>  /* The payload is a word consisting of a packet sequence number in the u=
pper
>   * 16-bits and a intra packet data sequence number in the lower 16 bits.=
 So the 3rd packet's
> @@ -256,7 +283,8 @@ static void __test_spec_init(struct test_spec *test, =
struct ifobject *ifobj_tx,
>  		ifobj->xsk->umem->frame_size =3D XSK_UMEM__DEFAULT_FRAME_SIZE;
>  	}
>=20=20
> -	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING))
> +	if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING) &&
> +	    ifobj_is_local(ifobj_tx))
>  		hw_ring_size_reset(ifobj_tx);
>=20=20
>  	test->ifobj_tx =3D ifobj_tx;
> @@ -264,7 +292,6 @@ static void __test_spec_init(struct test_spec *test, =
struct ifobject *ifobj_tx,
>  	test->current_step =3D 0;
>  	test->total_steps =3D 1;
>  	test->nb_sockets =3D 1;
> -	test->fail =3D false;
>  	test->set_ring =3D false;
>  	test->adjust_tail =3D false;
>  	test->adjust_tail_support =3D false;
> @@ -332,26 +359,31 @@ static void test_spec_set_xdp_prog(struct test_spec=
 *test, struct bpf_program *x
>  	test->xskmap_tx =3D xskmap_tx;
>  }
>=20=20
> -static int test_spec_set_mtu(struct test_spec *test, int mtu)
> +static int test_spec_set_mtu_ifobj(struct ifobject *ifobj, int mtu)
>  {
>  	int err;
>=20=20
> -	if (test->ifobj_rx->mtu !=3D mtu) {
> -		err =3D xsk_set_mtu(test->ifobj_rx->ifindex, mtu);
> +	if (ifobj_is_local(ifobj) && ifobj->mtu !=3D mtu) {
> +		err =3D xsk_set_mtu(ifobj->ifindex, mtu);
>  		if (err)
>  			return err;
> -		test->ifobj_rx->mtu =3D mtu;
> -	}
> -	if (test->ifobj_tx->mtu !=3D mtu) {
> -		err =3D xsk_set_mtu(test->ifobj_tx->ifindex, mtu);
> -		if (err)
> -			return err;
> -		test->ifobj_tx->mtu =3D mtu;
>  	}
>=20=20
> +	ifobj->mtu =3D mtu;
>  	return 0;
>  }
>=20=20
> +static int test_spec_set_mtu(struct test_spec *test, int mtu)
> +{
> +	int err;
> +
> +	err =3D test_spec_set_mtu_ifobj(test->ifobj_rx, mtu);
> +	if (err)
> +		return err;
> +
> +	return test_spec_set_mtu_ifobj(test->ifobj_tx, mtu);
> +}
> +
>  void pkt_stream_reset(struct pkt_stream *pkt_stream)
>  {
>  	if (pkt_stream) {
> @@ -1001,6 +1033,9 @@ static int __receive_pkts(struct test_spec *test, s=
truct xsk_socket_info *xsk)
>  	fds.fd =3D xsk_socket__fd(xsk->xsk);
>  	fds.events =3D POLLIN;
>=20=20
> +	if (pacing_rx_progress(0))
> +		return TEST_FAILURE;
> +
>  	ret =3D kick_rx(xsk);
>  	if (ret)
>  		return TEST_FAILURE;
> @@ -1100,9 +1135,8 @@ static int __receive_pkts(struct test_spec *test, s=
truct xsk_socket_info *xsk)
>  	if (ifobj->release_rx)
>  		xsk_ring_cons__release(&xsk->rx, frags_processed);
>=20=20
> -	pthread_mutex_lock(&pacing_mutex);
> -	pkts_in_flight -=3D pkts_sent;
> -	pthread_mutex_unlock(&pacing_mutex);
> +	if (pacing_rx_progress(pkts_sent))
> +		return TEST_FAILURE;
>  	pkts_sent =3D 0;
>=20=20
>  	return TEST_CONTINUE;
> @@ -1178,9 +1212,18 @@ static int __send_pkts(struct ifobject *ifobject, =
struct xsk_socket_info *xsk,
>  	int ret;
>=20=20
>  	buffer_len =3D pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
> +	if (pacing_tx_sync())
> +		return TEST_FAILURE;
> +
>  	/* pkts_in_flight might be negative if many invalid packets are sent */
>  	if (pkts_in_flight >=3D (int)((umem_size(umem) - xsk->batch_size * buff=
er_len) /
>  	    buffer_len) && !test_timeout) {
> +		/* Only RX progress reports can lower pkts_in_flight. */
> +		if (xsk_peer_closed(ctrl_peer)) {
> +			ksft_print_msg("ERROR: [%s] RX exited with %d packets in flight\n",
> +				       __func__, pkts_in_flight);
> +			return TEST_FAILURE;
> +		}
>  		ret =3D kick_tx(xsk);
>  		if (ret)
>  			return TEST_FAILURE;
> @@ -1262,9 +1305,7 @@ static int __send_pkts(struct ifobject *ifobject, s=
truct xsk_socket_info *xsk,
>  		valid_frags +=3D nb_frags;
>  	}
>=20=20
> -	pthread_mutex_lock(&pacing_mutex);
>  	pkts_in_flight +=3D valid_pkts;
> -	pthread_mutex_unlock(&pacing_mutex);
>=20=20
>  	xsk_ring_prod__submit(&xsk->tx, i);
>  	xsk->outstanding_tx +=3D valid_frags;
> @@ -1341,9 +1382,6 @@ static int send_pkts(struct test_spec *test, struct=
 ifobject *ifobject)
>  			if (ret !=3D TEST_CONTINUE)
>  				return ret;
>=20=20
> -			if (test->fail)
> -				return TEST_FAILURE;
> -
>  			if (!test->poll_tmout) {
>  				ret =3D wait_for_tx_completion(&ifobject->xsk_arr[i]);
>  				if (ret)
> @@ -1665,36 +1703,57 @@ static int testapp_validate_rx_endpoint(struct te=
st_spec *test,
>  	return err;
>  }
>=20=20
> -void *worker_testapp_validate_tx(void *arg)
> +static int sync_endpoints(struct test_spec *test)
> +{
> +	int err =3D xsk_peer_ready(ctrl_peer);
> +
> +	if (err)
> +		ksft_print_msg("Endpoint synchronization failed at step %u: %d (%s)\n",
> +			       test->current_step, err, strerror(-err));
> +	return err;
> +}
> +
> +int worker_testapp_validate_tx(struct test_spec *test)
>  {
> -	struct test_spec *test =3D (struct test_spec *)arg;
>  	int err;
>=20=20
> -	err =3D testapp_validate_tx_endpoint(test, test->ifobj_tx);
> +	err =3D sync_endpoints(test);
>  	if (err)
> -		test->fail =3D true;
> +		return err;
>=20=20
> -	pthread_exit(NULL);
> +	err =3D testapp_validate_tx_endpoint(test, test->ifobj_tx);
> +	if (err) {
> +		ksft_print_msg("TX endpoint traffic failed at step %u: %d\n",
> +			       test->current_step, err);
> +		xsk_peer_abort(ctrl_peer);
> +	}
> +	return err;
>  }
>=20=20
> -void *worker_testapp_validate_rx(void *arg)
> +int worker_testapp_validate_rx(struct test_spec *test)
>  {
> -	struct test_spec *test =3D (struct test_spec *)arg;
>  	struct ifobject *ifobject =3D test->ifobj_rx;
>  	int err;
>=20=20
>  	err =3D testapp_prepare_rx_endpoint(test, ifobject);
> +	if (err) {
> +		ksft_print_msg("RX endpoint setup failed at step %u: %d\n",
> +			       test->current_step, err);
> +		xsk_peer_abort(ctrl_peer);
> +		return err;
> +	}
>=20=20
> -	if (test->use_barrier)
> -		pthread_barrier_wait(&barr);
> -
> -	/* We leave only now in case of error to avoid getting stuck in the bar=
rier */
> -	if (!err)
> -		err =3D testapp_validate_rx_endpoint(test, ifobject);
> +	err =3D sync_endpoints(test);
>  	if (err)
> -		test->fail =3D true;
> +		return err;
>=20=20
> -	pthread_exit(NULL);
> +	err =3D testapp_validate_rx_endpoint(test, ifobject);
> +	if (err) {
> +		ksft_print_msg("RX endpoint traffic failed at step %u: %d\n",
> +			       test->current_step, err);
> +		xsk_peer_abort(ctrl_peer);
> +	}
> +	return err;
>  }
>=20=20
>  static void testapp_clean_xsk_umem(struct ifobject *ifobj)
> @@ -1749,13 +1808,13 @@ static int xsk_attach_xdp_progs(struct test_spec =
*test, struct ifobject *ifobj_r
>  {
>  	int err =3D 0;
>=20=20
> -	if (xdp_prog_changed_rx(test)) {
> +	if (ifobj_is_local(ifobj_rx) && xdp_prog_changed_rx(test)) {
>  		err =3D xsk_reattach_xdp(ifobj_rx, test->xdp_prog_rx, test->xskmap_rx,=
 test->mode);
>  		if (err)
>  			return err;
>  	}
>=20=20
> -	if (!ifobj_tx)
> +	if (!ifobj_tx || !ifobj_is_local(ifobj_tx))
>  		return 0;
>=20=20
>  	if (xdp_prog_changed_tx(test))
> @@ -1768,7 +1827,7 @@ static void clean_sockets(struct test_spec *test, s=
truct ifobject *ifobj)
>  {
>  	u32 i;
>=20=20
> -	if (!ifobj || !test)
> +	if (!ifobj || !test || !ifobj_is_local(ifobj))
>  		return;
>=20=20
>  	for (i =3D 0; i < test->nb_sockets; i++)
> @@ -1780,15 +1839,15 @@ static void clean_umem(struct test_spec *test, st=
ruct ifobject *ifobj1, struct i
>  	if (!ifobj1)
>  		return;
>=20=20
> -	testapp_clean_xsk_umem(ifobj1);
> -	if (ifobj2)
> +	if (ifobj_is_local(ifobj1))
> +		testapp_clean_xsk_umem(ifobj1);
> +	if (ifobj2 && ifobj_is_local(ifobj2))
>  		testapp_clean_xsk_umem(ifobj2);
>  }
>=20=20
>  static int __testapp_validate_traffic(struct test_spec *test, struct ifo=
bject *ifobj1,
>  				      struct ifobject *ifobj2)
>  {
> -	pthread_t t0, t1;
>  	u32 mbuf_cap;
>  	int err;
>=20=20
> @@ -1819,51 +1878,27 @@ static int __testapp_validate_traffic(struct test=
_spec *test, struct ifobject *i
>  			       err, strerror(-err));
>  		return TEST_FAILURE;
>  	}
> -	test->use_barrier =3D !!ifobj2;
> -
> -	if (test->use_barrier) {
> -		if (pthread_barrier_init(&barr, NULL, 2))
> -			return TEST_FAILURE;
>=20=20
> +	if (ifobj2)
>  		pkt_stream_reset(ifobj2->xsk->pkt_stream);
> -	}
> -
>  	test->current_step++;
>  	pkt_stream_reset(ifobj1->xsk->pkt_stream);
>  	pkts_in_flight =3D 0;
>=20=20
> -	/*Spawn RX thread */
> -	pthread_create(&t0, NULL, ifobj1->func_ptr, test);
> -
> -	if (test->use_barrier) {
> -		pthread_barrier_wait(&barr);
> -		if (pthread_barrier_destroy(&barr)) {
> -			test->use_barrier =3D false;
> -			pthread_join(t0, NULL);
> -			clean_sockets(test, ifobj1);
> -			clean_umem(test, ifobj1, NULL);
> -			return TEST_FAILURE;
> -		}
> -	}
> -
> -	if (ifobj2) {
> -		/*Spawn TX thread */
> -		pthread_create(&t1, NULL, ifobj2->func_ptr, test);
> -		pthread_join(t1, NULL);
> -	}
> -
> -	pthread_join(t0, NULL);
> -
> -	if (test->total_steps =3D=3D test->current_step || test->fail) {
> +	/* In a one-sided step, the idle endpoint only keeps in step. */
> +	if (ifobj_is_local(ifobj1))
> +		err =3D ifobj1->func_ptr(test);
> +	else if (ifobj2 && ifobj_is_local(ifobj2))
> +		err =3D ifobj2->func_ptr(test);
> +	else
> +		err =3D sync_endpoints(test);
> +	if (test->total_steps =3D=3D test->current_step || err) {
>  		clean_sockets(test, ifobj1);
>  		clean_sockets(test, ifobj2);
>  		clean_umem(test, ifobj1, ifobj2);
>  	}
>=20=20
> -	if (test->fail)
> -		return TEST_FAILURE;
> -
> -	return TEST_PASS;
> +	return err ? TEST_FAILURE : TEST_PASS;
>  }
>=20=20
>  static int testapp_validate_traffic(struct test_spec *test)
> @@ -1879,7 +1914,8 @@ static int testapp_validate_traffic(struct test_spe=
c *test)
>=20=20
>  	if (test->set_ring) {
>  		if (ifobj_has_cap(ifobj_tx, XSK_CAP_HW_RING)) {
> -			if (set_ring_size(ifobj_tx)) {
> +			if (ifobj_is_local(ifobj_tx) &&
> +			    set_ring_size(ifobj_tx)) {
>  				ksft_print_msg("Failed to change HW ring size.\n");
>  				return TEST_FAILURE;
>  			}
> @@ -1912,7 +1948,7 @@ int testapp_teardown(struct test_spec *test)
>=20=20
>  static void swap_directions(struct ifobject **ifobj1, struct ifobject **=
ifobj2)
>  {
> -	thread_func_t tmp_func_ptr =3D (*ifobj1)->func_ptr;
> +	test_func_t tmp_func_ptr =3D (*ifobj1)->func_ptr;
>  	struct ifobject *tmp_ifobj =3D (*ifobj1);
>=20=20
>  	(*ifobj1)->func_ptr =3D (*ifobj2)->func_ptr;
> @@ -1951,6 +1987,9 @@ static int swap_xsk_resources(struct test_spec *tes=
t)
>  	test->ifobj_tx->xsk =3D &test->ifobj_tx->xsk_arr[1];
>  	test->ifobj_rx->xsk =3D &test->ifobj_rx->xsk_arr[1];
>=20=20
> +	if (!ifobj_is_local(test->ifobj_rx))
> +		return TEST_PASS;
> +
>  	ret =3D xsk_update_xskmap(test->ifobj_rx->xskmap, test->ifobj_rx->xsk->=
xsk, 0);
>  	if (ret)
>  		return TEST_FAILURE;
> @@ -2299,7 +2338,7 @@ int testapp_too_many_frags(struct test_spec *test)
>  	return ret;
>  }
>=20=20
> -static int xsk_load_xdp_programs(struct ifobject *ifobj)
> +int xsk_load_xdp_programs(struct ifobject *ifobj)
>  {
>  	ifobj->xdp_progs =3D xsk_xdp_progs__open_and_load();
>  	if (libbpf_get_error(ifobj->xdp_progs))
> @@ -2357,12 +2396,10 @@ static int detect_ifobj_caps(struct ifobject *ifo=
bj)
>  	return 0;
>  }
>=20=20
> -int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
> +int init_iface(struct ifobject *ifobj)
>  {
>  	int err;
>=20=20
> -	ifobj->func_ptr =3D func_ptr;
> -
>  	err =3D xsk_load_xdp_programs(ifobj);
>  	if (err) {
>  		ksft_print_msg("Error loading XDP program\n");
> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testi=
ng/selftests/net/lib/xsk/test_xsk.h
> index 861a2ee3b8e1..53e5032510a0 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> @@ -77,9 +77,13 @@ enum test_mode {
>  struct ifobject;
>  struct test_spec;
>  typedef int (*validation_func_t)(struct ifobject *ifobj);
> -typedef void *(*thread_func_t)(void *arg);
>  typedef int (*test_func_t)(struct test_spec *test);
>=20=20
> +struct xsk_peer;
> +
> +/* The control channel to the other endpoint. */
> +void xsk_set_endpoint(struct xsk_peer *peer);
> +
>  struct xsk_socket_info {
>  	struct xsk_ring_cons rx;
>  	struct xsk_ring_prod tx;
> @@ -139,7 +143,7 @@ struct ifobject {
>  	struct xsk_caps caps;
>  	struct xsk_socket_info *xsk;
>  	struct xsk_socket_info *xsk_arr;
> -	thread_func_t func_ptr;
> +	test_func_t func_ptr;
>  	validation_func_t validation_func;
>  	struct xsk_xdp_progs *xdp_progs;
>  	struct bpf_map *xskmap;
> @@ -169,11 +173,18 @@ static inline void ifobj_set_cap(struct ifobject *i=
fobj, u32 cap)
>  	ifobj->caps.flags |=3D cap;
>  }
>=20=20
> +/* The shadow of the peer's ifobject is never bound to an interface. */
> +static inline bool ifobj_is_local(const struct ifobject *ifobj)
> +{
> +	return ifobj->ifindex;
> +}
> +
>  #define xsk_get_cap(test, cap) ((test)->ifobj_tx->caps.cap)
>=20=20
>  struct ifobject *ifobject_create(void);
>  void ifobject_delete(struct ifobject *ifobj);
> -int init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
> +int init_iface(struct ifobject *ifobj);
> +int xsk_load_xdp_programs(struct ifobject *ifobj);
>=20=20
>  int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *ume=
m, void *buffer, u64 size);
>  int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_in=
fo *umem,
> @@ -222,12 +233,10 @@ struct test_spec {
>  	u16 total_steps;
>  	u16 current_step;
>  	u16 nb_sockets;
> -	bool fail;
>  	bool set_ring;
>  	bool adjust_tail;
>  	bool adjust_tail_support;
>  	bool poll_tmout;
> -	bool use_barrier;
>  	enum test_mode mode;
>  	char name[MAX_TEST_NAME_SIZE];
>  };
> @@ -288,8 +297,8 @@ int testapp_xdp_metadata_mb(struct test_spec *test);
>  int testapp_xdp_prog_cleanup(struct test_spec *test);
>  int testapp_xdp_shared_umem(struct test_spec *test);
>=20=20
> -void *worker_testapp_validate_rx(void *arg);
> -void *worker_testapp_validate_tx(void *arg);
> +int worker_testapp_validate_rx(struct test_spec *test);
> +int worker_testapp_validate_tx(struct test_spec *test);
>=20=20
>  static const struct test_spec tests[] =3D {
>  	{.name =3D "SEND_RECEIVE", .test_func =3D testapp_send_receive},
> diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.c b/tools/testi=
ng/selftests/net/lib/xsk/xsk_peer.c
> new file mode 100644
> index 000000000000..e3e353d6abd9
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <arpa/inet.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <netdb.h>
> +#include <netinet/tcp.h>
> +#include <poll.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/socket.h>
> +#include <unistd.h>
> +
> +#include "xsk_peer.h"
> +
> +#define XSK_PEER_MAGIC			0x58534b50
> +#define XSK_PEER_ACCEPT_TMOUT_MS	30000
> +
> +/*
> + * One case per connection; the launcher owns the verdict. As with the c=
ontrol
> + * channels of other selftests, the test hosts are trusted: nothing
> + * authenticates the peer.
> + */
> +enum xsk_peer_msg_type {
> +	XSK_PEER_READY =3D 1,
> +	XSK_PEER_PROGRESS,
> +	XSK_PEER_ABORT,
> +};
> +
> +struct xsk_peer_msg {
> +	u32 magic;
> +	u32 type;
> +	u32 pkts;
> +};
> +
> +struct xsk_peer {
> +	int fd;
> +	u32 acked;
> +	bool ready_seen;
> +	bool closed;
> +};
> +
> +static int io_full(int fd, void *buf, size_t len, bool write_op)
> +{
> +	size_t done =3D 0;
> +	ssize_t ret;
> +
> +	while (done < len) {
> +		if (write_op)
> +			ret =3D send(fd, (char *)buf + done, len - done, MSG_NOSIGNAL);
> +		else
> +			ret =3D read(fd, (char *)buf + done, len - done);
> +		if (ret < 0 && errno =3D=3D EINTR)
> +			continue;
> +		if (ret < 0)
> +			return -errno;
> +		if (!ret)
> +			return -EPIPE;
> +		done +=3D ret;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Past its last barrier the peer may exit at any time, and it resets the
> + * connection if our progress reports are still unread.
> + */
> +static bool peer_gone(int err)
> +{
> +	return err =3D=3D -EPIPE || err =3D=3D -ECONNRESET;
> +}
> +
> +static int peer_send(struct xsk_peer *peer, u32 type, u32 pkts)
> +{
> +	struct xsk_peer_msg msg =3D {
> +		.magic =3D htonl(XSK_PEER_MAGIC),
> +		.type =3D htonl(type),
> +		.pkts =3D htonl(pkts),
> +	};
> +
> +	return io_full(peer->fd, &msg, sizeof(msg), true);
> +}
> +
> +static int peer_recv_one(struct xsk_peer *peer)
> +{
> +	struct xsk_peer_msg msg;
> +	u32 pkts;
> +	int err;
> +
> +	err =3D io_full(peer->fd, &msg, sizeof(msg), false);
> +	if (peer_gone(err))
> +		peer->closed =3D true;
> +	if (err)
> +		return err;
> +	if (ntohl(msg.magic) !=3D XSK_PEER_MAGIC)
> +		return -EPROTO;
> +
> +	switch (ntohl(msg.type)) {
> +	case XSK_PEER_READY:
> +		/* The peer waits for our READY, so it is at most one step ahead. */
> +		if (peer->ready_seen)
> +			return -EPROTO;
> +		peer->ready_seen =3D true;
> +		return 0;
> +	case XSK_PEER_PROGRESS:
> +		/* xsk_peer_tx_sync() returns the sum as an int. */
> +		pkts =3D ntohl(msg.pkts);
> +		if (pkts > INT_MAX - peer->acked)
> +			return -EPROTO;
> +		peer->acked +=3D pkts;
> +		return 0;
> +	case XSK_PEER_ABORT:
> +		return -ECANCELED;
> +	default:
> +		return -EPROTO;
> +	}
> +}
> +
> +/*
> + * Consume what the peer has sent so far without blocking. A closed conn=
ection
> + * is not an error here, see peer_gone(); xsk_peer_closed() reports it.
> + */
> +static int peer_drain(struct xsk_peer *peer)
> +{
> +	struct pollfd pfd =3D { .fd =3D peer->fd, .events =3D POLLIN };
> +	int ret;
> +
> +	while (!peer->closed) {
> +		ret =3D poll(&pfd, 1, 0);
> +		if (ret < 0 && errno =3D=3D EINTR)
> +			continue;
> +		if (ret < 0)
> +			return -errno;
> +		if (!ret)
> +			break;
> +		ret =3D peer_recv_one(peer);
> +		if (ret && !peer->closed)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +/* Return once both endpoints are set up for the next step. */
> +int xsk_peer_ready(struct xsk_peer *peer)
> +{
> +	int err;
> +
> +	err =3D peer_send(peer, XSK_PEER_READY, 0);
> +	while (!err && !peer->ready_seen)
> +		err =3D peer_recv_one(peer);
> +	if (err)
> +		return err;
> +
> +	/* TCP ordering puts all progress of the previous step before READY. */
> +	peer->ready_seen =3D false;
> +	peer->acked =3D 0;
> +	return 0;
> +}
> +
> +void xsk_peer_abort(struct xsk_peer *peer)
> +{
> +	if (peer && !peer->closed)
> +		peer_send(peer, XSK_PEER_ABORT, 0);
> +}
> +
> +int xsk_peer_rx_progress(struct xsk_peer *peer, u32 pkts)
> +{
> +	int err;
> +
> +	if (pkts && !peer->closed) {
> +		err =3D peer_send(peer, XSK_PEER_PROGRESS, pkts);
> +		/*
> +		 * Leave closed to peer_drain(), which first reads what the
> +		 * peer sent before it went away, such as an ABORT.
> +		 */
> +		if (err && !peer_gone(err))
> +			return err;
> +	}
> +	return peer_drain(peer);
> +}
> +
> +/* Return the packets RX reported consumed since the last call, or -errn=
o. */
> +int xsk_peer_tx_sync(struct xsk_peer *peer)
> +{
> +	int err =3D peer_drain(peer);
> +	u32 acked =3D peer->acked;
> +
> +	if (err)
> +		return err;
> +	peer->acked =3D 0;
> +	return acked;
> +}
> +
> +bool xsk_peer_closed(struct xsk_peer *peer)
> +{
> +	return peer->closed;
> +}
> +
> +static int accept_tmout(int lfd)
> +{
> +	struct pollfd pfd =3D { .fd =3D lfd, .events =3D POLLIN };
> +	int ret;
> +
> +	do {
> +		ret =3D poll(&pfd, 1, XSK_PEER_ACCEPT_TMOUT_MS);
> +	} while (ret < 0 && errno =3D=3D EINTR);
> +	if (!ret)
> +		errno =3D ETIMEDOUT;
> +	return ret > 0 ? accept(lfd, NULL, NULL) : -1;
> +}
> +
> +/*
> + * The listener says on stderr when it listens, and the launcher waits f=
or
> + * that line before it starts the connector, so connect() needs no retry.
> + * accept() is bounded in case the connector exits before it gets that f=
ar.
> + */
> +static int peer_open_tcp(const char *host, const char *port, bool listen=
_side)
> +{
> +	struct addrinfo hints =3D {
> +		.ai_family =3D AF_UNSPEC,
> +		.ai_socktype =3D SOCK_STREAM,
> +		.ai_flags =3D AI_NUMERICSERV,
> +	};
> +	int fd =3D -1, lfd, saved =3D ECONNREFUSED, one =3D 1, err;
> +	struct addrinfo *res, *ai;
> +
> +	err =3D getaddrinfo(host, port, &hints, &res);
> +	if (err)
> +		return -EINVAL;
> +
> +	if (!listen_side)
> +		goto conn;
> +
> +	for (ai =3D res; ai; ai =3D ai->ai_next) {
> +		lfd =3D socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> +		if (lfd < 0)
> +			continue;
> +		setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
> +		if (!bind(lfd, ai->ai_addr, ai->ai_addrlen) && !listen(lfd, 1)) {
> +			fprintf(stderr, "Listening for XSK peer on port %s\n", port);
> +			fd =3D accept_tmout(lfd);
> +			saved =3D errno;
> +			close(lfd);
> +			break;
> +		}
> +		saved =3D errno;
> +		close(lfd);
> +	}
> +	freeaddrinfo(res);
> +	return fd >=3D 0 ? fd : -saved;
> +
> +conn:
> +	for (ai =3D res; ai; ai =3D ai->ai_next) {
> +		fd =3D socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> +		if (fd < 0)
> +			continue;
> +		if (!connect(fd, ai->ai_addr, ai->ai_addrlen))
> +			break;
> +		saved =3D errno;
> +		close(fd);
> +		fd =3D -1;
> +	}
> +	freeaddrinfo(res);
> +	return fd >=3D 0 ? fd : -saved;
> +}
> +
> +struct xsk_peer *xsk_peer_open(const char *host, const char *port,
> +			       bool listen_side)
> +{
> +	int fd =3D peer_open_tcp(host, port, listen_side);
> +	struct xsk_peer *peer;
> +	int one =3D 1;
> +
> +	if (fd < 0) {
> +		errno =3D -fd;
> +		return NULL;
> +	}
> +	peer =3D calloc(1, sizeof(*peer));
> +	if (!peer) {
> +		close(fd);
> +		return NULL;
> +	}
> +	peer->fd =3D fd;
> +	setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));
> +	return peer;
> +}
> +
> +void xsk_peer_close(struct xsk_peer *peer)
> +{
> +	if (peer) {
> +		close(peer->fd);
> +		free(peer);
> +	}
> +}
> diff --git a/tools/testing/selftests/net/lib/xsk/xsk_peer.h b/tools/testi=
ng/selftests/net/lib/xsk/xsk_peer.h
> new file mode 100644
> index 000000000000..da4462192994
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef XSK_PEER_H_
> +#define XSK_PEER_H_
> +
> +#include <linux/types.h>
> +
> +struct xsk_peer;
> +
> +struct xsk_peer *xsk_peer_open(const char *host, const char *port,
> +			       bool listen_side);
> +void xsk_peer_close(struct xsk_peer *peer);
> +
> +int xsk_peer_ready(struct xsk_peer *peer);
> +void xsk_peer_abort(struct xsk_peer *peer);
> +int xsk_peer_rx_progress(struct xsk_peer *peer, u32 pkts);
> +int xsk_peer_tx_sync(struct xsk_peer *peer);
> +bool xsk_peer_closed(struct xsk_peer *peer);
> +
> +#endif /* XSK_PEER_H_ */
> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/tes=
ting/selftests/net/lib/xsk/xskxceiver.c
> index 09ad623333be..769718cad8cd 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> @@ -9,9 +9,9 @@
>   * See test_xsk.py for detailed information on test topology
>   * and prerequisite network setup.
>   *
> - * This test program contains two threads, each thread is single socket =
with
> - * a unique UMEM. It validates in-order packet delivery and packet conte=
nt
> - * by sending packets to each other.
> + * Each instance of this test program runs one endpoint, Tx or Rx, with a
> + * single socket and a unique UMEM. Two instances validate in-order pack=
et
> + * delivery and packet content by sending packets to each other.
>   *
>   * Tests Information:
>   * ------------------
> @@ -57,12 +57,14 @@
>   *
>   * Flow:
>   * -----
> - * - Single process spawns two threads: Tx and Rx
> - * - Each of these two threads attach to a veth interface
> - * - Each thread creates one AF_XDP socket connected to a unique umem fo=
r each
> + * - test_xsk.py starts two processes: Tx and Rx
> + * - Each of these two processes attach to a veth interface
> + * - Each process creates one AF_XDP socket connected to a unique umem f=
or each
>   *   veth interface
> - * - Tx thread Transmits a number of packets from veth<xxxx> to veth<yyy=
y>
> - * - Rx thread verifies if all packets were received and delivered in-or=
der,
> + * - Tx process listens on a TCP control port, Rx process connects to it=
 and
> + *   the two synchronize each test step over that connection
> + * - Tx process Transmits a number of packets from veth<xxxx> to veth<yy=
yy>
> + * - Rx process verifies if all packets were received and delivered in-o=
rder,
>   *   and have the right content
>   */
>=20=20
> @@ -87,6 +89,7 @@
>  #include <sys/types.h>
>=20=20
>  #include "test_xsk.h"
> +#include "xsk_peer.h"
>  #include "xsk_xdp_progs.skel.h"
>  #include "xsk.h"
>  #include "xskxceiver.h"
> @@ -95,8 +98,18 @@
>  #include "kselftest.h"
>  #include "xsk_xdp_common.h"
>=20=20
> +enum xsk_endpoint_role {
> +	XSK_ENDPOINT_NONE,
> +	XSK_ENDPOINT_RX,
> +	XSK_ENDPOINT_TX,
> +};
> +
>  static enum test_mode opt_mode =3D TEST_MODE_ALL;
>  static u32 opt_run_test =3D RUN_ALL_TESTS;
> +static enum xsk_endpoint_role opt_endpoint_role =3D XSK_ENDPOINT_NONE;
> +static const char *opt_peer_host;
> +static const char *opt_peer_port;
> +static const char *opt_ifname;
>=20=20
>  static void __exit_with_error(int error, const char *file, const char *f=
unc, int line)
>  {
> @@ -157,6 +170,9 @@ static struct option long_options[] =3D {
>  	{"mode", required_argument, 0, 'm'},
>  	{"list", no_argument, 0, 'l'},
>  	{"test", required_argument, 0, 't'},
> +	{"endpoint", required_argument, 0, 'e'},
> +	{"peer", required_argument, 0, 'p'},
> +	{"peer-port", required_argument, 0, 'P'},
>  	{"help", no_argument, 0, 'h'},
>  	{0, 0, 0, 0}
>  };
> @@ -164,7 +180,7 @@ static struct option long_options[] =3D {
>  static void print_usage(char **argv)
>  {
>  	const char *str =3D
> -		"  Usage: xskxceiver -i TX_IFACE -i RX_IFACE -m MODE -t TEST [OPTIONS]=
\n"
> +		"  Usage: xskxceiver -i IFACE -e rx|tx -m MODE -t TEST -p HOST -P PORT=
 [OPTIONS]\n"
>  		"  Options:\n"
>  		"  -i, --interface      Use interface\n"
>  		"  -v, --verbose        Verbose output\n"
> @@ -172,16 +188,18 @@ static void print_usage(char **argv)
>  		"  -m, --mode           Mode to run: skb, drv or zc\n"
>  		"  -l, --list           List all available tests\n"
>  		"  -t, --test           Test case to run, a number from -l\n"
> +		"  -e, --endpoint       Role of this endpoint: rx or tx\n"
> +		"  -p, --peer           Control host: IPv4/IPv6 address or hostname\n"
> +		"  -P, --peer-port      Control TCP port (1-65535)\n"
>  		"  -h, --help           Display this help and exit\n";
>=20=20
>  	ksft_print_msg(str, basename(argv[0]));
>  	ksft_exit_xfail();
>  }
>=20=20
> -static void bind_iface(struct ifobject *ifobj, const char *ifname, threa=
d_func_t func,
> -		       char **argv)
> +static void bind_iface(struct ifobject *ifobj, const char *ifname, char =
**argv)
>  {
> -	size_t len =3D ifname ? strlen(ifname) : 0;
> +	size_t len =3D strlen(ifname);
>=20=20
>  	if (!len || len >=3D sizeof(ifobj->ifname))
>  		print_usage(argv);
> @@ -193,7 +211,7 @@ static void bind_iface(struct ifobject *ifobj, const =
char *ifname, thread_func_t
>  		ksft_exit_fail();
>  	}
>=20=20
> -	if (init_iface(ifobj, func)) {
> +	if (init_iface(ifobj)) {
>  		ksft_print_msg("Error: cannot initialize interface %s\n", ifobj->ifnam=
e);
>  		ksft_exit_fail();
>  	}
> @@ -208,26 +226,33 @@ static void print_tests(void)
>  		printf("%u: %s\n", i, tests[i].name);
>  }
>=20=20
> +static u32 parse_u32(const char *arg, u32 min, u32 max, char **argv)
> +{
> +	unsigned long val;
> +	char *end;
> +
> +	errno =3D 0;
> +	val =3D strtoul(arg, &end, 10);
> +	if (arg[0] < '0' || arg[0] > '9' || errno || *end || val < min || val >=
 max)
> +		print_usage(argv);
> +	return val;
> +}
> +
>  static void parse_command_line(struct ifobject *ifobj_tx, struct ifobjec=
t *ifobj_rx, int argc,
>  			       char **argv)
>  {
> -	const char *ifname[2] =3D {};
> -	u32 interface_nb =3D 0;
>  	int option_index, c;
>=20=20
>  	opterr =3D 0;
>=20=20
>  	for (;;) {
> -		c =3D getopt_long(argc, argv, "i:vbm:lt:", long_options, &option_index=
);
> +		c =3D getopt_long(argc, argv, "i:vbm:lt:e:p:P:", long_options, &option=
_index);
>  		if (c =3D=3D -1)
>  			break;
>=20=20
>  		switch (c) {
>  		case 'i':
> -			if (interface_nb >=3D ARRAY_SIZE(ifname))
> -				break;
> -
> -			ifname[interface_nb++] =3D optarg;
> +			opt_ifname =3D optarg;
>  			break;
>  		case 'v':
>  			opt_verbose =3D true;
> @@ -256,17 +281,31 @@ static void parse_command_line(struct ifobject *ifo=
bj_tx, struct ifobject *ifobj
>  			if (errno)
>  				print_usage(argv);
>  			break;
> +		case 'e':
> +			if (!strcmp(optarg, "rx"))
> +				opt_endpoint_role =3D XSK_ENDPOINT_RX;
> +			else if (!strcmp(optarg, "tx"))
> +				opt_endpoint_role =3D XSK_ENDPOINT_TX;
> +			else
> +				print_usage(argv);
> +			break;
> +		case 'p':
> +			opt_peer_host =3D optarg;
> +			break;
> +		case 'P':
> +			parse_u32(optarg, 1, UINT16_MAX, argv);

If you respin; This is useless. Remove this and the function. We'll
catch an incorrect port elsewhere.


Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
