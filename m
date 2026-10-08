Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6948FF6E;
	Thu,  8 Oct 2026 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451034; cv=none; b=IghBuo5DHW5D2NnKboMXVEmTUe7CrhCHluXZURFIaKgSLD0/8IYCR6cP2m/yfpjv3X7uBDavPWN69oAI3fHq6ncG+ZmdPruJ4Z5Toce92N3lul9W1lYB2/210J5GBo6oYk3hG+/ieIZHeO7EkAht7ODG68sla7yY/BSOutCVMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451034; c=relaxed/simple;
	bh=10yWz9W2m1LcH51BrnFzn+QOLghb0LH9r7Ly/8FSQ/U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NSkaldecbMSXWeoA80qZUWHaQeesVyEY+qyhIvSO87lgB6J15HIlZgUKuKci+Q9bUSReHkRHXAuyIiwSjuSNgozK7eEq4nCLBXICDSR4rcb+HpGRHRSyXEJmVUYycunGoSrxQvP12jcBwXJ1Zp6nmxJNDONnqed3J26FWVMENvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=U/7ZHNUp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="U/7ZHNUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791451000; x=1792055800; i=t.fuechsel@gmx.de;
	bh=6ZbGD0GD8tOVyh9ckbj+XIMMOeZsmWAcKZaUsc/UjYU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U/7ZHNUpzkhxpVA53vLcwyx6r45hO//j6HKLw+pbvGcY5hznRg5KLOkj+GTDSuDN
	 SZmqT34vpQTBib1sdcOO01HBzDmJfVdX9poXO07dDkLupU3nDKLJQj4NpZoUIs0fl
	 Ew1cZkeU6xTFpIuC17GOvwOqAjH0if3auTBGkKlYCDW71F0u/tRGA08uwASZfI3b2
	 abmdGc6/Hr6c4W8PNfEXsrUX2cPAtNafpcMv2hoSnbfFA7n/94XJ4FfDknc+X4ESc
	 ONXucuxyjLU2y0p7qGyb1cCfVvNRLE3VDiGgaeOtKsstozkh7EShVhB+JAdQsDNkz
	 tBUe5K75/XDsILOD0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1xRxdo17wG-00FkpD; Thu, 08
 Oct 2026 11:16:40 +0200
Date: Thu, 8 Oct 2026 11:16:36 +0200
From: Tim Fuechsel <t.fuechsel@gmx.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, fmancera@suse.de, ebiggers@kernel.org,
	bpf@vger.kernel.org,
	Lukas Prause <lukas.prause@ikt.uni-hannover.de>,
	Tim Fuechsel <t.fuechsel@gmx.de>
Subject: [PATCHv10 net-next] tcp: Add TCP ROCCET congestion control module.
Message-ID: <asdfdDIQb7Nhm692@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xModNMEsfSzYfG6Oo9POpEMeMVITdHafWH1xQ3MwrACHjWQAHNc
 Fb1kwttkPuFrhC3TwoyFNEC5UJ9hFp55SD9Jnz9TqDXmRptVVUVsFWbtIMironmeG8NdJxi
 dMPQIOaGkkuPjnSP/vV5V+jMNwQJ5VzMeXvN5/kCnXEsDVuoCVl1z+D/Jmv+nS0FP9aJ/eO
 NW1nWv/D8/iDury8RanmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vEjM7UKo4Qg=;sTacRJVvuF/4tlPMoKE2bJspMyK
 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
 72BbQ0LZ+6AJneuTBz83xMkvqofws=

TCP ROCCET is a new congestion control algorithm based on TCP CUBIC
that improves its overall performance in cellular networks. By its mode
of function, CUBIC causes bufferbloat while it tries to detect the
available throughput of a network path. This is particularly a problem
with large buffers in mobile networks. A more detailed description and
analysis of this problem caused by TCP CUBIC can be found in [1].
TCP ROCCET's main method of addressing the bufferbloat problem is by
adding two additional metrics. The first metric is the relative increase
in RTT from its minimum, the srRTT. Here, bufferbloat can be detected
when RTTs increase due to buffer filling. The second metric is the
acknowledgment arrival rate sampled over 100ms intervals and the bytes
sent and received over 5 RTTs. If CUBIC increases the send rate or
congestion window, and the acknowledgment arrival rate stays at the
same level, the connection is limited by the bottleneck link's capacity.
In such cases, ROCCET reduces the send rate to prevent bufferbloat.
ROCCET uses a modified version of slow start rather than HyStart because
HyStart is known to enter the congestion avoidance phase too early when
used in cellular networks [2]. Therefore, ROCCET uses a combination of
srRTT and the acknowledgment arrival rate to determine when to exit slow
start. For the congestion avoidance phase, ROCCET relies on the srRTT and
monitoring the sent and received bytes to detect the filling of the
bottleneck buffer. To keep the minimum RTT updated, ROCCET performs
minimum RTT probing if no new minimum RTT was found in the last 5 seconds.
To this end ROCCET halves the cwnd and probes for 200ms but at least for
one RTT, for a new minimum RTT. After probing, ROCCET refills the pipe
carefully. In addition, ROCCET reacts to packet loss by adapting CUBIC's
behavior. ECNs are handled as ROCCET congestion event, where the cwnd gets
reduced and ROCCET enters a buffer drain state.

In real-world mobile 5G NR measurements, TCP ROCCET achieves better
performance than CUBIC, by maintaining similar throughput while reducing
the latency. More information about TCP ROCCET and measurement evaluations
can be found here [3].
For the version (2026-07-21), we provide additional performance evaluation
regarding throughput, latency, and bandwidth share [4].

[1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
[2] https://doi.org/10.1109/WMNC.2016.7543932
[3] https://doi.org/10.23919/WONS68803.2026.11501781
[4] http://go.lu-h.de/roccet-2026-07-21

Co-developed-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Signed-off-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Signed-off-by: Tim Fuechsel <t.fuechsel@gmx.de>

=2D--

Changes since v1:
	* Adjust some comments & Rework commit message
	* Fix Kconfig format
	* Add div-by-0 check variables
	* Fix ack summation from +=3D1 to +=3Dacked (counting now ACKs instead of=
 ACK events)
	* Fix wrapping in time comparisons
	* Remove most module_params, including 'ignore_loss'
	* Remove check that always evaluated to 'true' regarding 'bw_limit_detect=
'

Changes since v2:
	* Improve initialization of roccettcp struct
	* Always react to ECE bits and reset flag
	* Detect plateaus in ACK-rate
	* Fix potential overflow in ACK-rate tracking for high-speed connections
	* Reset ACK-counter correctly on new interval
	* Fix potential integer overflow in rRTT calculation

Changes since v3:
	* Changes in comments & Kconfig help text
	* Adjust commit message, adding reference to new performance evaluation
	* Add minimum RTT probing
	* Use cong_control callback instead of cong_avoid
	* Move CA_EVENT_TX_START event check to dedicated callback (cwnd_event_tx=
_start)
	* Add monitoring of send and receive rate as mentioned in the original pa=
per
	* Refactor of the code
	* Remove kfunc exports
	* Fix potential overflow in rRTT calculation by using 64-bit arithmetic
	* Fix potential division-by-zero in srRTT calculation due to RTT value
	* Initialize ack_rate timestamp to current time
	* Fix potential double penalty when receiving ECN (ECE) mark
	* Reset ack counting when connection goes idle
	* Add module-parameter bounds check on register

Changes since v4:
	* Remove __always_inline annotations & unused function
	* Fix module parameter bounds check desync
	* Add idle-check to fix connection freezing
	* Exchange .ssthresh callback from recalc_ssthresh to a ssthresh-getter, =
fixing double penalties
	* Remove unnecessary seq-no wrapping check & Remove 0 as 'uninitialized' =
seq-no value
	* Wait for first control round to finish before starting to monitor poten=
tial slow-start exit conditions

Changes since v5:
	* Complete refactor of the roccet-state-machine, improving maintainabilit=
y and robustness
	* Fix incorrect state transitions and state-exit conditions
	* Reconsider & fix handling of RTO, CWR and Recovery states
	* Fix module parameter usage & only re-calculate scaling factors on modul=
e-init
	* Fix usage of .ssthresh callback and use ssthresh more consciously
	* Fix incorrect coding-style

Changes since v6:
	* Add beta param-setter with bounds check
	* Set cwnd on loss to 1 instead of TCP_INIT_CWND
	* Fix exceeding of ICSK_CA_PRIV_SIZE size
	* Fix DRAIN-state stuck due to idle-periods & wrap arounds
	* Fix ack-carry-over applied to wrong metric

Changes since v7:
	* Rewrite idle-check in update_ack_rate code
	* Add min RTT probe interval to cubic-epoch timer
	* Set seq.-no counters on ORBITER enter
	* Don't set Wmax when CWR occurs during RTT probing
	* Increase cwnd back to TCP_CWND_INIT on RTO

Changes since v8:
	* Fix RTT_PROBE_REFILL to DRAIN transition leaving jiffies in `next_min_r=
tt_probe`
	* Add previously ignored `acked` value to `ack_rate_cnt` on reset
	* Add upper bound for min RTT probe duration
	* Fix more potential time-wrap problems
	* Add a `tcp_in_slow_start()` guard for `tcp_slow_start()` call in LAUNCH
	* Clamp epoch_start so it won't go in the future
	* Set `snd_ssthresh` on RTO & on ROCCET-CE
	* Automatically set `initial_limit_reached` after max 500 ms
	* Avoid double-cwnd-reduction via tcp_in_cwnd_reduction check
	* Avoid cwnd growth in cwnd-reduction state
	* Keep pacing rate att 100% in RTT_PROBE state

Changes since v9:
	* Don't discard all rtt samples after fast recovery in min RTT probing
	* Enter LAUNCH after sufficient idle period
	* Fix outdated comments
	* Apply snd_cwnd_clamp everywhere
	* Remove possibility for double ROCCET CE in ORBITER
	* Fix incorrect implicit s32->u64 cast for `sent_more_than_acked`
	* Fix some incorrect parameter resets on roccet_reset
=2D--
 net/ipv4/Kconfig      |   12 +
 net/ipv4/Makefile     |    1 +
 net/ipv4/tcp_roccet.c | 1408 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1421 insertions(+)
 create mode 100644 net/ipv4/tcp_roccet.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 301b47660305..3545fb0a045b 100644
=2D-- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -663,6 +663,18 @@ config TCP_CONG_CDG
 	    delay gradients." In Networking 2011. Preprint:
 	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-prepri=
nt.pdf
=20
+config TCP_CONG_ROCCET
+	tristate "ROCCET TCP"
+	default n
+	help
+	  TCP ROCCET (RTT oriented CUBIC congestion control exTension) is a
+	  sender-side-only congestion control algorithm based on the TCP CUBIC
+	  protocol stack/TCP CUBIC congestion control algorithm that optimizes
+	  its performance. Especially for networks with large buffers
+	  (wireless, cellular networks), TCP ROCCET has improved performance by
+	  maintaining a similar throughput as CUBIC while reducing latency.
+	  For more information, see: https://arxiv.org/abs/2510.25281
+
 config TCP_CONG_BBR
 	tristate "BBR TCP"
 	default n
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 06e21c26b76f..69e4baaed122 100644
=2D-- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_INET_TCP_DIAG) +=3D tcp_diag.o
 obj-$(CONFIG_INET_UDP_DIAG) +=3D udp_diag.o
 obj-$(CONFIG_INET_RAW_DIAG) +=3D raw_diag.o
 obj-$(CONFIG_TCP_CONG_BBR) +=3D tcp_bbr.o
+obj-$(CONFIG_TCP_CONG_ROCCET) +=3D tcp_roccet.o
 obj-$(CONFIG_TCP_CONG_BIC) +=3D tcp_bic.o
 obj-$(CONFIG_TCP_CONG_CDG) +=3D tcp_cdg.o
 obj-$(CONFIG_TCP_CONG_CUBIC) +=3D tcp_cubic.o
diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
new file mode 100644
index 000000000000..04b9e5246612
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,1408 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TCP ROCCET: An RTT-Oriented CUBIC Congestion Control
+ * Extension for 5G and Beyond Networks
+ *
+ * TCP ROCCET is a new TCP congestion control
+ * algorithm suited for current cellular 5G NR beyond networks.
+ * It extends the kernel default congestion control CUBIC
+ * and improves its performance, and additionally solves an
+ * unwanted side effects of CUBIC=E2=80=99s implementation.
+ * ROCCET uses its own Slow Start, called LAUNCH, where loss
+ * is not considered as a congestion event.
+ * The congestion avoidance phase, called ORBITER, uses
+ * CUBIC's window growth function and adds, based on RTT
+ * and ACK rate, congestion events.
+ *
+ * A peer-reviewed paper on TCP ROCCET which was presented
+ * at the WONS 2026 conference is available here:
+ *	https://opendl.ifip-tc6.org/db/conf/wons/wons2026/1571217211.pdf
+ *
+ *
+ * This module is based on the kernel CUBIC TCP implementation
+ * (see net/ipv4/tcp_cubic.c). Branched module at kernel version 7.1.
+ */
+
+#include <linux/jiffies.h>
+#include <linux/math64.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/printk.h>
+#include <linux/time.h>
+#include <net/tcp.h>
+#include <vdso/time64.h>
+
+/* Scale factor beta calculation (max_cwnd =3D snd_cwnd * beta) */
+#define BICTCP_BETA_SCALE 1024
+
+#define BICTCP_HZ 10 /* BIC HZ 2^10 =3D 1024 */
+
+/* Alpha value for the srRTT  multiplied by 100.
+ * Here 20 represents a value of 0.2
+ */
+#define ROCCET_ALPHA_TIMES_100 20
+
+/* min RTT probe period in ms */
+#define ROCCET_NEXT_MIN_RTT_PROBE_MS 5000
+
+/* The maximum interval length of a min RTT probe
+ * (and consequently also the max interval for the refill).
+ */
+#define ROCCET_MAX_PROBE_INTERVAL_MS 10000
+
+#define ROCCET_MAX_SRRTT_CHECK_INTERVAL_MS (5 * 200)
+
+/* State in which roccet currently operates */
+enum roccet_state {
+	LAUNCH,
+	ORBITER,
+	RTT_PROBE_ENTER,
+	RTT_PROBE,
+	RTT_PROBE_REFILL,
+	DRAIN
+};
+
+/* TCP ROCCET struct based on the original BICTCP struct with
+ * additions specific to the ROCCET-Algorithm.
+ */
+struct roccettcp {
+	u32 cnt;	/* increase cwnd by 1 after ACKs */
+	u32 last_max_cwnd;	/* last maximum snd_cwnd */
+	u32 last_cwnd;	/* the last snd_cwnd */
+	u32 last_time;	/* time when updated last_cwnd */
+	u32 bic_origin_point;	/* origin point of bic function */
+	u32 bic_K;	/* time to origin point from the
+			 * beginning of the current epoch
+			 */
+	u32 delay_min;	/* min delay (usec) */
+	u32 epoch_start;	/* beginning of an epoch */
+	u32 ack_cnt;	/* number of acks */
+	u32 tcp_cwnd;	/* estimated tcp cwnd */
+	u32 curr_rtt;	/* last sample rtt of current round */
+
+	u32 roccet_last_event_time_us;	/* The last time ROCCET was triggered */
+	u32 curr_min_rtt;	/* The current observed minRTT */
+	u32 next_min_rtt_probe;	/* Next time to probe the minRTT */
+	u32 probe_min_rtt_until;	/* End of minRTT probing period.
+					 * Set while in RTT_PROBE states
+					 */
+	u32 refill_until;	/* End of pipe refill after minRTT probe.
+				 * Set while in RTT_PROBE states
+				 */
+	u32 cwnd_before_min_rtt_probe;	/* cwnd before min RTT probing. */
+	u32 curr_srrtt;	/* srRTT calculated based on the latest ACK */
+	u32 next_srrtt_check_ts;	/* Next check for srRTT */
+	u32 last_rtt;	/* sample rtt of previous round.
+			 * Used for jitter calculation
+			 */
+
+	u32 interval_snd_seq_start;
+	u32 interval_una_seq_start;
+
+	u32 ack_carry_over;	/* Used to carry over leftover acks from
+				 * LAUNCH to ORBITER
+				 */
+
+	u32 last_ack_rate_time;	/* Timestamp of the last ACK-rate */
+	u16 ack_rate_last_rate;	/* Last ACK-rate */
+	u16 curr_ack_rate;	/* Current ACK-rate */
+	u16 ack_rate_cnt;	/* Used for counting acks */
+
+	enum roccet_state state : 3; /* Current operating state of roccet */
+	bool initial_limit_reached: 1;	/* Set to true after the connection
+					 * initially gets cwnd-limited
+					 */
+	bool is_in_initial_launch: 1;	/* true if the connection is in
+					 * the initial launch phase.
+					 */
+	bool last_event_time_set: 1;	/* true if the last event time
+					 * has been set/initialized.
+					 */
+	bool rtt_probe_timers_set: 1;	/* true if refill_until and
+					 * probe_min_rtt_until are currently
+					 * set.
+					 */
+};
+
+/* Parameters that are specific to the ROCCET-Algorithm */
+static uint sr_rtt_upper_bound __read_mostly =3D 100;
+static int ack_rate_diff_ss __read_mostly =3D 10;
+
+module_param(sr_rtt_upper_bound, uint, 0644);
+MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
+module_param(ack_rate_diff_ss, int, 0644);
+MODULE_PARM_DESC(ack_rate_diff_ss,
+		 "ROCCET's threshold to exit slow start if ACK-rate differs by given am=
ount of segments.");
+
+static int fast_convergence __read_mostly =3D 1;
+static int beta __read_mostly =3D 717; /* =3D 717/1024 (BICTCP_BETA_SCALE=
) */
+static int initial_ssthresh __read_mostly;
+static int bic_scale __read_mostly =3D 41;
+static int tcp_friendliness __read_mostly =3D 1;
+
+static u32 cube_rtt_scale __read_mostly;
+static u32 beta_scale __read_mostly;
+static u64 cube_factor __read_mostly;
+
+static int beta_param_set(const char *val, const struct kernel_param *kp)=
;
+static const struct kernel_param_ops beta_param_ops =3D {
+	.set =3D beta_param_set,
+	.get =3D param_get_int,
+};
+module_param_cb(beta, &beta_param_ops, &beta, 0644);
+MODULE_PARM_DESC(beta, "beta factor for multiplicative decrease");
+
+module_param(fast_convergence, int, 0644);
+MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
+module_param(initial_ssthresh, int, 0644);
+MODULE_PARM_DESC(initial_ssthresh, "initial value of slow start threshold=
");
+module_param(bic_scale, int, 0444);
+MODULE_PARM_DESC(bic_scale,
+		 "scale (scaled by 1024) value for bic function (bic_scale/1024)");
+module_param(tcp_friendliness, int, 0644);
+MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
+
+/* Check & set the new beta parameter candidate value.
+ */
+static int beta_param_set(const char *val, const struct kernel_param *kp)
+{
+	int beta_candidate;
+	int ret =3D kstrtoint(val, 10, &beta_candidate);
+
+	if (ret)
+		return ret;
+
+	if (beta_candidate <=3D 0 || beta_candidate >=3D BICTCP_BETA_SCALE) {
+		pr_err_once("TCP ROCCET: beta must be between 0 and %d\n",
+			    BICTCP_BETA_SCALE);
+
+		return -EINVAL;
+	}
+
+	return param_set_int(val, kp);
+}
+
+/* Used to check certain roccet parameters used in `param_precompute` in =
order
+ * to avoid invalid scale-related calculations. This validates the specif=
ied
+ * parameters or rejects them.
+ */
+static int param_check(void)
+{
+	if (beta <=3D 0 || beta >=3D BICTCP_BETA_SCALE) {
+		pr_err_once("TCP ROCCET: beta must be between 0 and %d\n",
+			    BICTCP_BETA_SCALE);
+
+		return -EINVAL;
+	}
+
+	if (bic_scale <=3D 0) {
+		pr_err_once("TCP ROCCET: bic_scale must be positive\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Precompute some values based on the provided params.
+ * These are only precomputed during module initialization and are not up=
dated
+ * during runtime. Parameter changes at runtime will only affect the next=
 uses
+ * of the parameters, but not the precomputed values.
+ */
+static void param_precompute(void)
+{
+	/* Precompute a bunch of the scaling factors that are used per-packet
+	 * based on sRTT of 100ms.
+	 */
+	beta_scale =3D
+		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
+
+	cube_rtt_scale =3D (bic_scale * 10); /* 1024*c/rtt */
+
+	/* calculate the "K" for (wmax-cwnd) =3D c/rtt * K^3
+	 *  so K =3D cubic_root( (wmax-cwnd)*rtt/c )
+	 * the unit of K is bictcp_HZ=3D2^10, not HZ
+	 *
+	 *  c =3D bic_scale >> 10
+	 *  rtt =3D 100ms
+	 *
+	 * the following code has been designed and tested for
+	 * cwnd < 1 million packets
+	 * RTT < 100 seconds
+	 * HZ < 1,000,00  (corresponding to 10 nano-second)
+	 */
+
+	/* 1/c * 2^2*bictcp_HZ * srtt */
+	cube_factor =3D 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
+
+	/* divide by bic_scale and by constant srtt (100ms) */
+	do_div(cube_factor, bic_scale * 10);
+}
+
+static void roccet_reset(struct sock *sk, struct roccettcp *ca)
+{
+	/* Save previous state for parameters that should not be reset */
+	bool prev_initial_limit_reached =3D ca->initial_limit_reached;
+	bool prev_is_in_initial_launch =3D ca->is_in_initial_launch;
+
+	/* Reset all the roccet parameters and later restore the ones that
+	 * shouldn't be zero.
+	 */
+	memset(ca, 0, sizeof(struct roccettcp));
+
+	/* Initialize all RTT values to U32_MAX, so that any lower samples
+	 * will be accepted.
+	 */
+	ca->curr_min_rtt =3D U32_MAX;
+	ca->curr_rtt =3D U32_MAX;
+	ca->last_rtt =3D U32_MAX;
+
+	/* Initialize the last event time to the current time, to use it for
+	 * temporarily knowing when the connection started (only used for this
+	 * after init).
+	 */
+	ca->roccet_last_event_time_us =3D jiffies_to_usecs(tcp_jiffies32);
+
+	/* Initialize to current time to avoid an
+	 * overflow in the ack rate calculation
+	 */
+	ca->last_ack_rate_time =3D jiffies_to_usecs(tcp_jiffies32);
+
+	ca->interval_snd_seq_start =3D tcp_sk(sk)->snd_nxt;
+	ca->interval_una_seq_start =3D tcp_sk(sk)->snd_una;
+
+	/* Start state is LAUNCH */
+	ca->state =3D LAUNCH;
+
+	/* Set saved state for certain parameters */
+	ca->initial_limit_reached =3D prev_initial_limit_reached;
+	ca->is_in_initial_launch =3D prev_is_in_initial_launch;
+}
+
+static void roccet_init(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	roccet_reset(sk, ca);
+
+	/* Reset some parameters here, so they only get set during init */
+	ca->initial_limit_reached =3D false;
+	ca->is_in_initial_launch =3D true;
+
+	if (initial_ssthresh)
+		WRITE_ONCE(tcp_sk(sk)->snd_ssthresh, initial_ssthresh);
+
+	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
+}
+
+static void roccet_set_next_srrtt_check_ts(struct roccettcp *ca, u32 now)
+{
+	/* Check the srrtt after 5 RTT's. Cap the assumed RTT's
+	 * at 200 ms each =3D> 1 sec max.
+	 */
+	ca->next_srrtt_check_ts =3D now + min(5 * ca->curr_rtt,
+					    ROCCET_MAX_SRRTT_CHECK_INTERVAL_MS
+					    * USEC_PER_MSEC);
+}
+
+static void roccet_set_next_min_rtt_probe_ts(struct roccettcp *ca)
+{
+	/* Probe for the min RTT in ROCCET_NEXT_MIN_RTT_PROBE_MS
+	 * if no other update occurs.
+	 * If we are in either RTT_PROBE or RTT_PROBE_REFILL, don't set
+	 * the next probe time so we know when we approximately entered
+	 * the probing phase.
+	 */
+
+	if (ca->state =3D=3D RTT_PROBE || ca->state =3D=3D RTT_PROBE_REFILL)
+		return;
+
+	ca->next_min_rtt_probe =3D jiffies_to_usecs(tcp_jiffies32) +
+				 ROCCET_NEXT_MIN_RTT_PROBE_MS * USEC_PER_MSEC;
+}
+
+static void update_min_rtt(struct roccettcp *ca)
+{
+	/* Check if new lower min RTT was found. If so, set it directly.
+	 * If no valid RTT sample has been received yet, the check will fail,
+	 * since the rtt values are initialized to U32_MAX.
+	 */
+	if (ca->curr_rtt < ca->curr_min_rtt) {
+		ca->curr_min_rtt =3D max(ca->curr_rtt, 1);
+		roccet_set_next_min_rtt_probe_ts(ca);
+	}
+}
+
+/* Return difference between last and current ack rate.
+ */
+static s32 get_ack_rate_diff(struct roccettcp *ca)
+{
+	if (ca->curr_ack_rate < ca->ack_rate_last_rate)
+		return 0;
+	return (s32)(ca->curr_ack_rate - ca->ack_rate_last_rate);
+}
+
+/* Update ack rate sampled by 100ms.
+ */
+static void update_ack_rate(struct roccettcp *ca, u32 acked, u32 now)
+{
+	const s32 idle_threshold =3D USEC_PER_SEC * 2;
+	const s32 interval =3D USEC_PER_MSEC * 100;
+
+	/* Check if the last interval has elapsed.
+	 *
+	 * Check via time_between32, so that idle connections
+	 * (for more than U32_MAX/2 usecs), also trigger a new update
+	 * and don't stall the ack-counting.
+	 */
+	bool interval_elapsed =3D !time_between32(now, ca->last_ack_rate_time
+						  - interval,
+						  ca->last_ack_rate_time
+						  + interval);
+
+	if (interval_elapsed) {
+		/* Check if the connection was idle for *idle_threshold*
+		 * seconds (e.g. no ACK for X seconds). If so, reset the ack
+		 * counting as if a new connection was created.
+		 */
+		if (!time_between32(now, ca->last_ack_rate_time
+					- idle_threshold,
+					ca->last_ack_rate_time
+					+ idle_threshold)) {
+			ca->ack_rate_last_rate =3D 0;
+			ca->curr_ack_rate =3D 0;
+		} else {
+			/* start counting for the new interval */
+			ca->ack_rate_last_rate =3D ca->curr_ack_rate;
+			ca->curr_ack_rate =3D ca->ack_rate_cnt;
+		}
+		/* Start ack-counting with the already present ACKs */
+		ca->ack_rate_cnt =3D min_t(u32, acked, U16_MAX);
+		ca->last_ack_rate_time =3D now;
+	} else {
+		/* Cap the ack count to avoid overflow.
+		 * If we there are more than U16_MAX ACKs in 100ms,
+		 * the resulting LAUNCH-exit won't cause any harm.
+		 */
+		ca->ack_rate_cnt =3D min_t(u32, ca->ack_rate_cnt + acked,
+					 U16_MAX);
+	}
+}
+
+/* Compute srRTT.
+ */
+static void update_srrtt(struct roccettcp *ca)
+{
+	u64 rrtt;
+
+	/* Avoid integer overflow in the calculation below.
+	 * This could occur in cases where we have not yet
+	 * received an RTT sample after a min_rtt reset.
+	 * In these cases, set the rtt to a safe value.
+	 */
+	if (ca->curr_rtt < ca->curr_min_rtt) {
+		ca->curr_rtt =3D max(ca->curr_rtt, 1);
+		ca->curr_min_rtt =3D ca->curr_rtt;
+	}
+
+	/* ca->curr_min_rtt can never be 0. For completeness, we check for this
+	 * anyways in order to avoid division by zero errors.
+	 */
+	if (ca->curr_min_rtt =3D=3D 0) {
+		pr_err_once("TCP ROCCET: Recorded curr_min_rtt is 0\n");
+		return; /* skip srRTT update */
+	}
+
+	/* Calculate the new rRTT (Scaled by 100).
+	 * 100 * ((sRTT - sRTT_min) / sRTT_min).
+	 *
+	 * curr_min_rtt is always <=3D than curr_rtt,
+	 * since this is the minimum of the rtt.
+	 *
+	 * 0 is a valid value for rrtt.
+	 *
+	 * If we have no valid RTT sample yet, curr_rtt and curr_min_rtt will
+	 * be U32_MAX. This ultimately results in no srrtt increase, which
+	 * is ok.
+	 */
+	rrtt =3D div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
+		       ca->curr_min_rtt);
+
+	/* (1 - alpha) * srRTT + alpha * rRTT */
+	ca->curr_srrtt =3D div_u64((100 - ROCCET_ALPHA_TIMES_100)
+				 * (u64)ca->curr_srrtt + ROCCET_ALPHA_TIMES_100
+				 * rrtt, 100);
+}
+
+/* Handle ROCCET loss/ECN during min RTT probing.
+ */
+static void roccet_min_rtt_probe_ce(struct roccettcp *ca, u32 cwnd)
+{
+	/* This should only be called in RTT_PROBE state */
+	if (ca->state !=3D RTT_PROBE)
+		return;
+
+	/* If ROCCET is in min RTT probing and a loss/ECN occurs,
+	 * we use the cwnd before the probing interval to
+	 * calculate the cwnd reduction and continue probing.
+	 * After min RTT probing the cwnd is set to the reduced
+	 * value. During min RTT probing it is very likely that
+	 * congestion was caused by the cwnd value before min
+	 * RTT probing.
+	 */
+
+	if (ca->cwnd_before_min_rtt_probe =3D=3D 0)
+		pr_warn_once("TCP ROCCET: cwnd_before_min_rtt_probe is 0 during RTT_PRO=
BE. This should not happen.\n");
+	else
+		cwnd =3D ca->cwnd_before_min_rtt_probe;
+
+	ca->cwnd_before_min_rtt_probe =3D
+		max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+/* Do a ROCCET congestion event.
+ */
+static void roccet_congestion_event(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 curr_cwnd =3D tcp_snd_cwnd(tp);
+
+	ca->epoch_start =3D 0;
+	ca->roccet_last_event_time_us =3D now;
+	ca->last_event_time_set =3D true;
+
+	if (ca->state =3D=3D RTT_PROBE) {
+		/* In case we are in RTT_PROBE, continue with this state, as
+		 * the CE was likely caused by the cwnd before probing.
+		 * However do react to the CE.
+		 */
+		roccet_min_rtt_probe_ce(ca, curr_cwnd);
+		return;
+	}
+
+	ca->cnt =3D 100 * curr_cwnd;
+
+	/* Set W_max only if the current cwnd is larger */
+	if (ca->last_max_cwnd < curr_cwnd)
+		ca->last_max_cwnd =3D curr_cwnd;
+
+	/* Reduce cwnd by beta */
+	tcp_snd_cwnd_set(tp, min(tp->snd_cwnd_clamp,
+				 max((curr_cwnd * beta)
+				     / BICTCP_BETA_SCALE, 2U)));
+
+	/* Re-adjust ssthresh in case of ORBITER Congestion Event */
+	WRITE_ONCE(tp->snd_ssthresh, tcp_snd_cwnd(tp));
+
+	if (ca->state =3D=3D LAUNCH) {
+		ca->state =3D ORBITER;
+	} else if (ca->state =3D=3D ORBITER || ca->state =3D=3D RTT_PROBE_REFILL=
) {
+		/* If we are in orbiter or currently refilling the pipe,
+		 * abort the refill.
+		 */
+		ca->state =3D DRAIN;
+	}
+	/* Other states (e.g. DRAIN or RTT_PROBE_ENTER) not handled as
+	 * we don`t want any action there.
+	 */
+}
+
+static void roccet_enter_min_rtt_probe(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 interval, probe_cwnd;
+
+	/* If probing is already set, there was a mix up.
+	 * Continue anyway so we can recover.
+	 */
+	if (ca->rtt_probe_timers_set)
+		pr_warn_once("TCP ROCCET: Probing time should not be set when entering =
RTT Probe\n");
+
+	/* Safeguard for an "infinite" probe. This should logically never
+	 * happen but still safeguard it.
+	 */
+	if (ca->curr_rtt =3D=3D U32_MAX) {
+		pr_warn_once("TCP ROCCET: curr_rtt is U32_MAX. Won't enter RTT_PROBE\n"=
);
+		ca->state =3D ORBITER;
+		return;
+	}
+
+	/* Use field to store when we entered min RTT probing. Here we use
+	 * jiffies to stay consistent with the epoch_start format.
+	 */
+	ca->next_min_rtt_probe =3D tcp_jiffies32;
+
+	/* Start min RTT probing. Probe for 1 RTT or at least 200ms.
+	 * Also bound the probe to a maximum of ROCCET_MAX_PROBE_INTERVAL_MS
+	 * to avoid any "invalid"/very large RTT samples from breaking
+	 * the probing and allowing ROCCET to recover afterwards.
+	 */
+	interval =3D max(200 * USEC_PER_MSEC, min(ca->curr_rtt,
+						ROCCET_MAX_PROBE_INTERVAL_MS
+						* USEC_PER_MSEC));
+
+	/* This is to handle deep shared buffers with loss-based
+	 * congestion control like CUBIC. If the cwnd is not limited
+	 * by the application but falsely detected (see ROCCET paper),
+	 * we have to empty the pipe more.
+	 * If the limit detection is correct this will cause no harm
+	 * to the tcp flow because the cwnd is not fully utilized and
+	 * we set the cwnd to its previous value after probing.
+	 */
+	if (!tcp_is_cwnd_limited(sk))
+		probe_cwnd =3D max(tcp_snd_cwnd(tp) / 3, TCP_INIT_CWND);
+	else
+		probe_cwnd =3D max(tcp_snd_cwnd(tp) / 2, TCP_INIT_CWND);
+
+	ca->probe_min_rtt_until =3D now + interval;
+	ca->cwnd_before_min_rtt_probe =3D tcp_snd_cwnd(tp);
+
+	/* Reduce the cwnd to drain the buffer for probing. */
+	tcp_snd_cwnd_set(tp, min(probe_cwnd, tp->snd_cwnd_clamp));
+
+	/* Reset current min RTT to allow probing for
+	 * a new lower and higher minimum RTT.
+	 */
+	ca->curr_min_rtt =3D U32_MAX;
+
+	/* Refill the pipe after probing.
+	 * For this we use the previous cwnd for another probing interval.
+	 */
+	ca->refill_until =3D ca->probe_min_rtt_until + interval;
+	ca->rtt_probe_timers_set =3D true; /* Now both timers are set. */
+
+	/* Now we know that ca->probe_min_rtt_until < ca->refill_until
+	 * and we advance to the next state of the probing phase.
+	 *
+	 * Wrap-arounds of these values are handled by the relevant
+	 * if-conditions.
+	 */
+	ca->state =3D RTT_PROBE;
+}
+
+/* Do minimum RTT probing.
+ */
+static void roccet_min_rtt_probe(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Here we are in RTT_PROBE, so the probing time should be set.
+	 * If not just continue and enter refill phase.
+	 *
+	 * probe_min_rtt_until wrap-arounds are handled by the time_between32
+	 * check.
+	 */
+	if (!ca->rtt_probe_timers_set)
+		pr_warn_once("TCP ROCCET: Probing time should be set\n");
+	else if (time_between32(now, ca->probe_min_rtt_until
+				    - ROCCET_MAX_PROBE_INTERVAL_MS
+				    * USEC_PER_MSEC, ca->probe_min_rtt_until))
+		/* No state change if we are in the probing interval. */
+		return;
+	else if (time_after32(now, ca->refill_until))
+		/* If the probe_min_rtt_until interval has passed we likely
+		 * just entered the refill interval, so go into
+		 * RTT_PROBE_REFILL. If we are not in the refill_until
+		 * interval, something went wrong and we should quickly exit
+		 * the probing phase.
+		 *
+		 * Wraps-arounds of refill_until are caught by the time_after32
+		 * check.
+		 */
+		pr_warn_once("TCP ROCCET: Skipped refill interval.\n");
+
+	/* Reset cwnd to refill the pipe and consequently clear the stored
+	 * window.
+	 * Also perform sanity check. This should never happen.
+	 */
+	if (ca->cwnd_before_min_rtt_probe =3D=3D 0)
+		pr_warn_once("TCP ROCCET: cwnd_before_min_rtt_probe is 0 during RTT_PRO=
BE.\n");
+	else
+		tcp_snd_cwnd_set(tp, min(ca->cwnd_before_min_rtt_probe,
+					 tp->snd_cwnd_clamp));
+
+	ca->cwnd_before_min_rtt_probe =3D 0;
+
+	/* Exit the RTT_PROBE state */
+	ca->state =3D RTT_PROBE_REFILL;
+}
+
+static void roccet_rtt_probe_refill(struct roccettcp *ca, u32 now)
+{
+	/* Once the refill interval is over, we can end the probing phase. */
+	if (!time_between32(now, ca->refill_until
+				 - ROCCET_MAX_PROBE_INTERVAL_MS
+				 * USEC_PER_MSEC, ca->refill_until)) {
+		/* End min RTT probing phase. */
+		ca->state =3D ORBITER;
+	}
+}
+
+/* calculate the cubic root of x using a table lookup followed by one
+ * Newton-Raphson iteration.
+ * Avg err ~=3D 0.195%
+ */
+static u32 cubic_root(u64 a)
+{
+	u32 x, b, shift;
+	/* cbrt(x) MSB values for x MSB values in [0..63].
+	 * Precomputed then refined by hand - Willy Tarreau
+	 *
+	 * For x in [0..63],
+	 *   v =3D cbrt(x << 18) - 1
+	 *   cbrt(x) =3D (v[x] + 10) >> 6
+	 */
+	static const u8 v[] =3D {
+		/* 0x00 */ 0,	54,  54,  54,  118, 118, 118, 118,
+		/* 0x08 */ 123, 129, 134, 138, 143, 147, 151, 156,
+		/* 0x10 */ 157, 161, 164, 168, 170, 173, 176, 179,
+		/* 0x18 */ 181, 185, 187, 190, 192, 194, 197, 199,
+		/* 0x20 */ 200, 202, 204, 206, 209, 211, 213, 215,
+		/* 0x28 */ 217, 219, 221, 222, 224, 225, 227, 229,
+		/* 0x30 */ 231, 232, 234, 236, 237, 239, 240, 242,
+		/* 0x38 */ 244, 245, 246, 248, 250, 251, 252, 254,
+	};
+
+	b =3D fls64(a);
+	if (b < 7) {
+		/* a in [0..63] */
+		return ((u32)v[(u32)a] + 35) >> 6;
+	}
+
+	b =3D ((b * 84) >> 8) - 1;
+	shift =3D (a >> (b * 3));
+
+	x =3D ((u32)(((u32)v[shift] + 10) << b)) >> 6;
+
+	/* Newton-Raphson iteration
+	 *                         2
+	 * x    =3D ( 2 * x  +  a / x  ) / 3
+	 *  k+1          k         k
+	 */
+	x =3D (2 * x + (u32)div64_u64(a, (u64)x * (u64)(x - 1)));
+	x =3D ((x * 341) >> 10);
+	return x;
+}
+
+/* Compute congestion window to use.
+ */
+static void bictcp_update(struct roccettcp *ca, u32 cwnd,
+			  u32 acked)
+{
+	u32 delta, bic_target, max_cnt;
+	u64 offs, t;
+
+	ca->ack_cnt +=3D acked; /* count the number of ACKed packets */
+
+	if (ca->last_cwnd =3D=3D cwnd &&
+	    (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
+		return;
+
+	/* The CUBIC function can update ca->cnt at most once per jiffy.
+	 * On all cwnd reduction events, ca->epoch_start is set to 0,
+	 * which will force a recalculation of ca->cnt.
+	 */
+	if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
+		goto tcp_friendliness;
+
+	ca->last_cwnd =3D cwnd;
+	ca->last_time =3D tcp_jiffies32;
+
+	if (ca->epoch_start =3D=3D 0) {
+		ca->epoch_start =3D tcp_jiffies32; /* record beginning */
+		ca->ack_cnt =3D acked; /* start counting */
+		ca->tcp_cwnd =3D cwnd; /* syn with cubic */
+
+		if (ca->last_max_cwnd <=3D cwnd) {
+			ca->bic_K =3D 0;
+			ca->bic_origin_point =3D cwnd;
+		} else {
+			/* Compute new K based on
+			 * (wmax-cwnd) * (srtt>>3 / HZ) / c * 2^(3*bictcp_HZ)
+			 */
+			ca->bic_K =3D cubic_root(cube_factor *
+					       (ca->last_max_cwnd - cwnd));
+			ca->bic_origin_point =3D ca->last_max_cwnd;
+		}
+	}
+
+	/* cubic function - calc */
+	/* calculate c * time^3 / rtt,
+	 *  while considering overflow in calculation of time^3
+	 * (so time^3 is done by using 64 bit)
+	 * and without the support of division of 64bit numbers
+	 * (so all divisions are done by using 32 bit)
+	 *  also NOTE the unit of those variables
+	 *	  time  =3D (t - K) / 2^bictcp_HZ
+	 *	  c =3D bic_scale >> 10
+	 * rtt  =3D (srtt >> 3) / HZ
+	 * !!! The following code does not have overflow problems,
+	 * if the cwnd < 1 million packets !!!
+	 */
+
+	t =3D (s32)(tcp_jiffies32 - ca->epoch_start);
+	t +=3D usecs_to_jiffies(ca->delay_min);
+
+	/* change the unit from HZ to bictcp_HZ */
+	t <<=3D BICTCP_HZ;
+	do_div(t, HZ);
+
+	if (t < ca->bic_K) /* t - K */
+		offs =3D ca->bic_K - t;
+	else
+		offs =3D t - ca->bic_K;
+
+	/* c/rtt * (t-K)^3 */
+	delta =3D (cube_rtt_scale * offs * offs * offs) >> (10 + 3 * BICTCP_HZ);
+	if (t < ca->bic_K) /* below origin*/
+		bic_target =3D ca->bic_origin_point - delta;
+	else /* above origin*/
+		bic_target =3D ca->bic_origin_point + delta;
+
+	/* cubic function - calc bictcp_cnt*/
+	if (bic_target > cwnd)
+		ca->cnt =3D cwnd / (bic_target - cwnd);
+	else
+		ca->cnt =3D 100 * cwnd; /* very small increment*/
+
+	/* The initial growth of cubic function may be too conservative
+	 * when the available bandwidth is still unknown.
+	 */
+	if (ca->last_max_cwnd =3D=3D 0 && ca->cnt > 20)
+		ca->cnt =3D 20; /* increase cwnd 5% per RTT */
+
+tcp_friendliness:
+	/* TCP Friendly */
+	if (tcp_friendliness) {
+		u32 scale =3D beta_scale;
+
+		delta =3D (cwnd * scale) >> 3;
+		if (delta > 0) {
+			while (ca->ack_cnt > delta) { /* update tcp cwnd */
+				ca->ack_cnt -=3D delta;
+				ca->tcp_cwnd++;
+			}
+		}
+
+		if (ca->tcp_cwnd > cwnd) { /* if bic is slower than tcp */
+			delta =3D ca->tcp_cwnd - cwnd;
+			max_cnt =3D cwnd / delta;
+			if (ca->cnt > max_cnt)
+				ca->cnt =3D max_cnt;
+		}
+	}
+
+	/* The maximum rate of cwnd increase CUBIC allows is 1 packet per
+	 * 2 packets ACKed, meaning cwnd grows at 1.5x per RTT.
+	 */
+	ca->cnt =3D max(ca->cnt, 2U);
+}
+
+static void roccet_launch_update(struct sock *sk, u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+
+	/* LAUNCH: Detect an exit point for tcp slow start
+	 * in networks with large buffers of multiple BDP
+	 * Like in cellular networks (5G, ...).
+	 *
+	 * Or exit LAUNCH if cwnd is too large for application layer
+	 * data rate (tcp cwnd validation).
+	 */
+	if ((ca->curr_srrtt > sr_rtt_upper_bound &&
+	     get_ack_rate_diff(ca) <=3D ack_rate_diff_ss) ||
+	     !tcp_in_slow_start(tp) ||
+	    (!tcp_is_cwnd_limited(sk) && ca->initial_limit_reached)) {
+		u32 new_cwnd;
+
+		ca->epoch_start =3D 0;
+
+		/* Handle initial LAUNCH. Most bufferbloat occurs here */
+		if (ca->is_in_initial_launch) {
+			/* Halving the cwnd will undo the previous step of slow
+			 * start. Which is fine since the pipe is already full.
+			 */
+			new_cwnd =3D tcp_snd_cwnd(tp) / 2;
+		} else {
+			new_cwnd =3D tcp_snd_cwnd(tp) - (tcp_snd_cwnd(tp) / 3);
+		}
+		tcp_snd_cwnd_set(tp, min(max(new_cwnd, TCP_INIT_CWND),
+					 tp->snd_cwnd_clamp));
+		WRITE_ONCE(tp->snd_ssthresh, tcp_snd_cwnd(tp));
+		ca->roccet_last_event_time_us =3D now;
+		ca->last_event_time_set =3D true;
+		ca->state =3D ORBITER;
+		return;
+	}
+
+	/* If not already exiting LAUNCH, grow cwnd similar to slow-start */
+	acked =3D tcp_slow_start(tp, acked);
+	/* If cwnd hits ssthresh, go to ORBITER and if any ACKs are
+	 * leftover save them for ORBITER.
+	 * Check via tcp_in_slow_start() in case no ACKs are left.
+	 */
+	if (!tcp_in_slow_start(tp)) {
+		ca->state =3D ORBITER;
+		ca->epoch_start =3D 0;
+		ca->ack_carry_over =3D acked;
+	}
+}
+
+static void roccet_orbiter_update(struct sock *sk, u32 acked)
+{
+	/* ORBITER: Increase the cwnd by using the CUBIC cwnd growth function,
+	 * if no roccet congestion event is detected.
+	 */
+
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	bool evaluate_srrtt =3D false;
+	bool sent_more_than_acked =3D false;
+	u32 roccet_xj, jitter, sent, received;
+
+	/* Enter DRAIN when roccet was recently triggered */
+	if (ca->last_event_time_set &&
+	    time_between32(now, ca->roccet_last_event_time_us
+				- 100 * USEC_PER_MSEC,
+				ca->roccet_last_event_time_us
+				+ 100 * USEC_PER_MSEC)) {
+		ca->state =3D DRAIN;
+		return;
+	}
+
+	/* Enter RTT_PROBE when the "timer" has expired.
+	 *
+	 * Since we are in ORBITER, we should have already received at least
+	 * one RTT sample. However safeguard against it if not.
+	 *
+	 * Use double the probing period as a guard space to avoid
+	 * idle-time locking us out of probing.
+	 */
+	if (!time_between32(now, ca->next_min_rtt_probe
+				 - 2 * ROCCET_NEXT_MIN_RTT_PROBE_MS
+				 * USEC_PER_MSEC, ca->next_min_rtt_probe) &&
+	    ca->curr_rtt !=3D U32_MAX) {
+		ca->state =3D RTT_PROBE_ENTER;
+		return;
+	}
+
+	/* Calculate jitter.
+	 * Since we are in ORBITER, we should have already received at least
+	 * one RTT sample. Even if not, ca->curr_rtt and ca->curr_min_rtt
+	 * (the divisor later on) are U32_MAX, so they cancel each other out.
+	 * And if ca->last_rtt is U32_MAX, roccet_xj will be very large, so
+	 * the srRTT will not exceed it.
+	 */
+	if ((s32)(ca->curr_rtt - ca->last_rtt) < 0)
+		jitter =3D ca->last_rtt - ca->curr_rtt;
+	else
+		jitter =3D ca->curr_rtt - ca->last_rtt;
+
+	/* Calculate if more bytes were sent than received
+	 * in the time interval.
+	 *
+	 * Handle wrap arounds by relying on unsigned subtraction.
+	 * e.g. if snd_nxt wraps to 10 and seq_start is U32_MAX - 10,
+	 * the subtraction will result in the value of 21.
+	 */
+	sent =3D tp->snd_nxt - ca->interval_snd_seq_start;
+	received =3D tp->snd_una - ca->interval_una_seq_start;
+
+	/* Check sent and received bytes from the previous interval.
+	 * Here we use a guard space of 1% of the current cwnd.
+	 * We do this to avoid a false positive evaluation due
+	 * to delays caused by jitter or scheduling.
+	 *
+	 * (s64)(s32)(sent - received) =3D> Preserves negative wrap-behavior
+	 * with explicit s64 conversion afterwards.
+	 */
+	sent_more_than_acked =3D (s64)(s32)(sent - received) >
+			       (s64)div_u64((u64)tcp_snd_cwnd(tp) *
+					    (u64)tp->mss_cache, 100);
+
+	/* Check if it's time to evaluate the srRTT */
+	if (!time_between32(now, ca->next_srrtt_check_ts
+				 - 2 * ROCCET_MAX_SRRTT_CHECK_INTERVAL_MS
+				 * USEC_PER_MSEC, ca->next_srrtt_check_ts)) {
+		evaluate_srrtt =3D true;
+
+		/* reset struct and set next end of period */
+		roccet_set_next_srrtt_check_ts(ca, now);
+
+		/* Reset Rate calculation */
+		ca->interval_snd_seq_start =3D tp->snd_nxt;
+		ca->interval_una_seq_start =3D tp->snd_una;
+	}
+
+	/* If we are in recovery, skip growth and further ROCCET-CE's. */
+	if (tcp_in_cwnd_reduction(sk))
+		return;
+
+	/* Respects the jitter of the connection and add it on top of
+	 * the upper bound for the srRTT.
+	 */
+	roccet_xj =3D div_u64((u64)jitter * 100, ca->curr_min_rtt) +
+			sr_rtt_upper_bound;
+
+	/* The srRTT exceeds the upper bound if bufferbloat happens.
+	 * Here, we want to reduce the cwnd and drain the buffer.
+	 */
+	if (ca->curr_srrtt > roccet_xj && evaluate_srrtt &&
+	    sent_more_than_acked) {
+		roccet_congestion_event(sk, now);
+		return;
+	}
+
+	/* Terminates this function if cwnd is not fully utilized.
+	 * In mobile networks like 5G, this termination causes the
+	 * cwnd to be frozen at an excessively high value. This is
+	 * because slow start or HyStart massively exceed the available
+	 * bandwidth and leave the cwnd at an excessively high value.
+	 * The cwnd cannot therefore be fully utilized because it is
+	 * limited by the connection capacity.
+	 */
+	if (!tcp_is_cwnd_limited(sk) || sent_more_than_acked)
+		return;
+
+	/* In case there are any ACKs left over from LAUNCH,
+	 * apply them now.
+	 */
+	if (ca->ack_carry_over) {
+		acked +=3D ca->ack_carry_over;
+		ca->ack_carry_over =3D 0;
+	}
+
+	bictcp_update(ca, tcp_snd_cwnd(tp), acked);
+	tcp_cong_avoid_ai(tp, max(1, ca->cnt), acked);
+}
+
+/* The Cubic ssthresh calculation is also used for ROCCET.
+ * Called before TCP-CC state changes to TCP_CA_Recovery, TCP_CA_CWR or
+ * TCP_CA_Loss. cwnd reduction is then handled in the roccet_state() call=
back.
+ */
+static u32 roccet_recalc_ssthresh(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 cwnd =3D tcp_snd_cwnd(tp);
+
+	/* In LAUNCH, we want no reduction on loss/ECN.
+	 * On ECN this is set later on in roccet_state()
+	 */
+	if (ca->state =3D=3D LAUNCH)
+		return cwnd;
+
+	/* In min RTT probe, use the cwnd before the probe to not undershoot */
+	if (ca->state =3D=3D RTT_PROBE)
+		cwnd =3D ca->cwnd_before_min_rtt_probe;
+
+	ca->epoch_start =3D 0;	/* end of epoch */
+
+	/* Wmax and fast convergence */
+	if (cwnd < ca->last_max_cwnd && fast_convergence)
+		ca->last_max_cwnd =3D (cwnd * (BICTCP_BETA_SCALE + beta))
+			/ (2 * BICTCP_BETA_SCALE);
+	else
+		ca->last_max_cwnd =3D cwnd;
+
+	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+/* Handle a recovery event and return the new cwnd.
+ */
+static u32 roccet_handle_recovery(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 cwnd =3D tcp_snd_cwnd(tp);
+
+	/* If a loss occurs in the refill phase of min RTT probing
+	 * we reduce the cwnd and abort the refill.
+	 */
+	if (ca->state =3D=3D RTT_PROBE_REFILL)
+		ca->state =3D ORBITER;
+
+	/* In RTT_PROBE we don`t want to change state or immediately reduce
+	 * the cwnd.
+	 */
+	if (ca->state =3D=3D RTT_PROBE) {
+		roccet_min_rtt_probe_ce(ca, cwnd);
+		return tcp_snd_cwnd(tp);
+	}
+
+	/* On loss in LAUNCH, enter ORBITER without a cwnd reduction. */
+	if (ca->state =3D=3D LAUNCH) {
+		ca->state =3D ORBITER;
+		return cwnd;
+	}
+
+	return max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+/* Checks for state roccet-transitions and performs necessary state (re)s=
ets.
+ * This is done in order to avoid the possibility of forgetting to correc=
tly
+ * set a state when entering certain states.
+ *
+ * This is used whenever a state change is possible
+ * (e.g. in roccet_state(), roccet_control(), ...).
+ */
+static void roccet_handle_state_transitions(struct sock *sk,
+					    enum roccet_state prev_state,
+					    u32 now)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	u32 now_jiffies =3D tcp_jiffies32;
+
+	if (ca->state =3D=3D prev_state)
+		return;
+
+	/* When we exit LAUNCH we can be sure that we are no longer in the
+	 * initial_launch. Also on any state transition from LAUNCH, we can
+	 * say that the tcp_is_cwnd_limited() is now valid.
+	 */
+	if (prev_state =3D=3D LAUNCH) {
+		ca->is_in_initial_launch =3D false;
+		ca->initial_limit_reached =3D true;
+	}
+
+	/* Whenever we enter ORBITER, we need to schedule the next SRTT check.
+	 * This will be set before evaluating the next_srrtt_check_ts condition
+	 * as this is only done in ORBITER.
+	 */
+	if (ca->state =3D=3D ORBITER) {
+		roccet_set_next_srrtt_check_ts(ca, now);
+		ca->interval_snd_seq_start =3D tp->snd_nxt;
+		ca->interval_una_seq_start =3D tp->snd_una;
+
+		/* Add the time we spent in the min RTT probing phase to the
+		 * epoch_start, so the cubic growth won't suddenly jump
+		 * after probing. Here we use the next_min_rtt_probe field
+		 * which we (ab)used to store the time when we entered min RTT
+		 * probing (in jiffies).
+		 */
+		if ((prev_state =3D=3D RTT_PROBE ||
+		     prev_state =3D=3D RTT_PROBE_REFILL)) {
+			if (ca->epoch_start !=3D 0) {
+				ca->epoch_start +=3D now_jiffies -
+						   ca->next_min_rtt_probe;
+				/* Clamp so that epoch_start doesn't go
+				 * in the future.
+				 */
+				if (after(ca->epoch_start, now_jiffies))
+					ca->epoch_start =3D now_jiffies;
+			}
+
+			roccet_set_next_min_rtt_probe_ts(ca);
+		}
+	}
+
+	/* In refill we can transition to DRAIN. In this case, overwrite the
+	 * jiffies ts
+	 */
+	if (ca->state =3D=3D DRAIN && prev_state =3D=3D RTT_PROBE_REFILL)
+		roccet_set_next_min_rtt_probe_ts(ca);
+
+	/* Whenever we leave the min RTT probing states (and not just
+	 * transition between them), we want to reset the probing timers.
+	 */
+	if ((prev_state =3D=3D RTT_PROBE_ENTER || prev_state =3D=3D RTT_PROBE ||
+	     prev_state =3D=3D RTT_PROBE_REFILL) &&
+	    (ca->state !=3D RTT_PROBE && ca->state !=3D RTT_PROBE_REFILL)) {
+		ca->probe_min_rtt_until =3D 0;
+		ca->refill_until =3D 0;
+		ca->rtt_probe_timers_set =3D false;
+	}
+}
+
+static void roccet_cwnd_event_tx_start(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	u32 now =3D tcp_jiffies32;
+	enum roccet_state prev_state =3D ca->state;
+	s32 delta;
+
+	delta =3D now - tcp_sk(sk)->lsndtime;
+
+	/* We were application limited (idle) for a while.
+	 * Shift epoch_start to keep cwnd growth to cubic curve.
+	 */
+	if (ca->epoch_start && delta > 0) {
+		ca->epoch_start +=3D delta;
+		if (after(ca->epoch_start, now))
+			ca->epoch_start =3D now;
+	}
+
+	/* After idle periods, go into LAUNCH with slow start */
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_slow_start_after_idle) &&
+	    delta >=3D inet_csk(sk)->icsk_rto) {
+		tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
+		tcp_snd_cwnd_set(tp, min(TCP_INIT_CWND, tp->snd_cwnd_clamp));
+		ca->state =3D LAUNCH;
+	}
+
+	roccet_handle_state_transitions(sk, prev_state, jiffies_to_usecs(now));
+}
+
+/* Handle different loss-states and perform adequate cwnd reductions.
+ */
+static void roccet_state(struct sock *sk, u8 new_state)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	u32 cwnd;
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	enum roccet_state prev_state =3D ca->state;
+
+	if (new_state =3D=3D TCP_CA_Loss) {
+		roccet_reset(sk, ca);
+		tcp_snd_cwnd_set(tp, min(TCP_INIT_CWND, tp->snd_cwnd_clamp));
+		WRITE_ONCE(tp->snd_ssthresh, max(tp->snd_ssthresh,
+						 tcp_snd_cwnd(tp)));
+	} else if (tcp_in_cwnd_reduction(sk)) {
+		/* In this case we don't want a further window reduction */
+	} else if (new_state =3D=3D TCP_CA_CWR) {
+		/* Handle CWR as ROCCET congestion event,
+		 * however afterwards always set Wmax to the current cwnd
+		 * except during min RTT probing.
+		 */
+		cwnd =3D tcp_snd_cwnd(tp);
+		roccet_congestion_event(sk, now);
+		if (ca->state !=3D RTT_PROBE_ENTER && ca->state !=3D RTT_PROBE &&
+		    ca->state !=3D RTT_PROBE_REFILL)
+			ca->last_max_cwnd =3D cwnd;
+	} else if (new_state =3D=3D TCP_CA_Recovery) {
+		/* Directly reduce cwnd and rely on pacing */
+		cwnd =3D roccet_handle_recovery(sk);
+		tcp_snd_cwnd_set(tp, min(cwnd, tp->snd_cwnd_clamp));
+	}
+
+	roccet_handle_state_transitions(sk, prev_state, now);
+}
+
+/* Update RTT samples and min RTT.
+ */
+static void roccet_acked(struct sock *sk, const struct ack_sample *sample=
)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	bool after_fast_recovery;
+	u32 delay;
+
+	/* Some calls are for duplicates without timestamps */
+	if (sample->rtt_us < 0)
+		return;
+
+	/* Check if we are right after fast recovery. */
+	after_fast_recovery =3D ca->epoch_start &&
+			      (s32)(tcp_jiffies32 - ca->epoch_start) < HZ;
+
+	/* If we are not after fast recovery or we are in RTT_PROBE however,
+	 * we want to record every new min-sample.
+	 */
+	if (!after_fast_recovery || ca->state =3D=3D RTT_PROBE) {
+		/* Get valid sample for roccet */
+		if (sample->rtt_us > 0) {
+			ca->last_rtt =3D ca->curr_rtt;
+			ca->curr_rtt =3D sample->rtt_us;
+		}
+	}
+
+	/* Otherwise discard delay samples right after fast recovery. */
+	if (after_fast_recovery)
+		return;
+
+	delay =3D sample->rtt_us;
+
+	if (delay =3D=3D 0)
+		delay =3D 1;
+
+	/* first call or link delay decreases */
+	if (ca->delay_min =3D=3D 0 || (s32)(delay - ca->delay_min) < 0)
+		ca->delay_min =3D delay;
+}
+
+/* Custom Pacing Rate for ROCCET TCP.
+ * The code here is similar to the pacing rate adjustments in tcp_input.c=
's
+ * tcp_update_pacing_rate(). In (modified) slow start we want a pacing
+ * following the sysctl_tcp_pacing_ss_ratio (usually 200%) parameter and
+ * otherwise (congestion avoidance) we adjust the pacing to 100% and do n=
ot
+ * use the sysctl_tcp_pacing_ca_ratio.
+ */
+static void roccet_update_pacing_rate(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	u64 rate;
+
+	/* set sk_pacing_rate to 200 % of current rate (mss * cwnd / srtt) */
+	rate =3D (u64)tp->mss_cache * ((div64_u64(USEC_PER_SEC, 100) << 3));
+
+	/* current rate is (cwnd * mss) / srtt
+	 * In slow-start [1], set sk_pacing_rate to sysctl_tcp_pacing_ss_ratio
+	 * (usually 200%) the current rate. Otherwise, set it to 100% the
+	 * current rate.
+	 *
+	 * [1]: Normal Slow Start cond is (tp->snd_cwnd < tp->snd_ssthresh)
+	 *	 If snd_cwnd >=3D (tp->snd_ssthresh / 2), we are approaching
+	 *	 end of slow start and should slow down.
+	 */
+	if (ca->state =3D=3D RTT_PROBE || tcp_snd_cwnd(tp) >=3D tp->snd_ssthresh=
 / 2)
+		/* Pacing rate of 100%
+		 * (instead of ipv4.sysctl_tcp_pacing_ca_ratio)
+		 */
+		rate *=3D 100;
+	else
+		/* Here we are well inside of slow start
+		 * (tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2)
+		 */
+		rate *=3D READ_ONCE
+			(sock_net(sk)->ipv4.sysctl_tcp_pacing_ss_ratio);
+
+	rate *=3D max(tcp_snd_cwnd(tp), tp->packets_out);
+
+	if (likely(tp->srtt_us))
+		do_div(rate, tp->srtt_us);
+
+	/* WRITE_ONCE() is needed because sch_fq fetches sk_pacing_rate
+	 * without any lock. We want to make sure compiler won't store
+	 * intermediate values in this location.
+	 */
+	WRITE_ONCE(sk->sk_pacing_rate,
+		   min_t(u64, rate, READ_ONCE(sk->sk_max_pacing_rate)));
+}
+
+static void roccet_drain_update(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* If we are in DRAIN, ca->roccet_last_event_time_us has to be set.
+	 * If more than 100 ms have passed after a roccet event, exit DRAIN.
+	 * The between check is here to handle idle-times and timer-wraps.
+	 * It is ok if we "accidentally" exit DRAIN in such an occasion.
+	 */
+	if (!time_between32(now, ca->roccet_last_event_time_us
+				- 100 * USEC_PER_MSEC,
+				ca->roccet_last_event_time_us
+				+ 100 * USEC_PER_MSEC)) {
+		if (tcp_in_slow_start(tp))
+			ca->state =3D LAUNCH;
+		else
+			ca->state =3D ORBITER;
+	}
+}
+
+static void roccet_control(struct sock *sk, u32 ack, int flag,
+			   const struct rate_sample *rs)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	enum roccet_state prev_state =3D ca->state;
+
+	/* Update ack rate. Even on no new acks/sacks. */
+	update_ack_rate(ca, rs->acked_sacked, now);
+	/* Only update RTT metrics if we have new acks/sacks in order to keep
+	 * EWMA from running multiple times for no new acks.
+	 */
+	if (rs->acked_sacked > 0) {
+		update_min_rtt(ca);
+		update_srrtt(ca);
+	}
+
+	/* Evaluate roccet state */
+	switch (ca->state) {
+	case LAUNCH:
+		roccet_launch_update(sk, rs->acked_sacked);
+		break;
+	case ORBITER:
+		roccet_orbiter_update(sk, rs->acked_sacked);
+		break;
+	case DRAIN:
+		/* In DRAIN the cwnd should not be increased */
+		roccet_drain_update(sk, now);
+		break;
+	case RTT_PROBE_ENTER:
+		roccet_enter_min_rtt_probe(sk, now);
+		break;
+	case RTT_PROBE:
+		roccet_min_rtt_probe(sk, now);
+		break;
+	case RTT_PROBE_REFILL:
+		roccet_rtt_probe_refill(ca, now);
+		break;
+	default:
+		pr_err_once("TCP ROCCET: Invalid state %d\n", ca->state);
+	}
+
+	roccet_handle_state_transitions(sk, prev_state, now);
+
+	roccet_update_pacing_rate(sk);
+
+	/* Abuse ca->roccet_last_event_time_us as the start time for this
+	 * connection (only after init, while initial_limit_reached is not
+	 * set). When the connection starts sending enough data or after 500 ms
+	 * we know that we can use tcp_is_cwnd_limited() to check if the
+	 * connection is actually limited by the cwnd and is not just
+	 * starting up.
+	 */
+	if (!ca->initial_limit_reached &&
+	    (tcp_is_cwnd_limited(sk) ||
+	     !time_between32(now, ca->roccet_last_event_time_us
+				  - 500 * USEC_PER_MSEC,
+				  ca->roccet_last_event_time_us
+				  + 500 * USEC_PER_MSEC)))
+		ca->initial_limit_reached =3D true;
+}
+
+static struct tcp_congestion_ops roccet_tcp __read_mostly =3D {
+	.init =3D roccet_init,
+	.ssthresh =3D roccet_recalc_ssthresh,
+	.set_state =3D roccet_state,
+	.undo_cwnd =3D tcp_reno_undo_cwnd,
+	.cwnd_event_tx_start =3D roccet_cwnd_event_tx_start,
+	.pkts_acked =3D roccet_acked,
+	.cong_control =3D roccet_control,
+	.owner =3D THIS_MODULE,
+	.name =3D "roccet",
+};
+
+static int __init roccet_register(void)
+{
+	int param_err;
+
+	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);
+
+	/* Check for valid parameter ranges and then precompute factors */
+	param_err =3D param_check();
+
+	if (param_err)
+		return param_err;
+
+	param_precompute();
+
+	return tcp_register_congestion_control(&roccet_tcp);
+}
+
+static void __exit roccet_unregister(void)
+{
+	tcp_unregister_congestion_control(&roccet_tcp);
+}
+
+module_init(roccet_register);
+module_exit(roccet_unregister);
+
+MODULE_AUTHOR("Lukas Prause, Tim F=C3=BCchsel");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ROCCET TCP");

base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
=2D-=20
2.43.0

