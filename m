Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C854E5342;
	Mon, 28 Sep 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608333; cv=none; b=KhtZmFYCVTl2301Y7rtXUfdxUVcRr/R+rZcX/di0y8hN3N5WMPZ8hQFRMU3Qn70Zoqrt0zXV4ugVv5oREvkYL8Vuc4nS+JO2W543peAaoJRbLJzRnQIwP3ie8ZkhaOyllXqi9xBhNhZc9Co36UK97+rsof7PQaZvqFayuKXCqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608333; c=relaxed/simple;
	bh=nudF22TgRH1sdDitPhwsRBZUpGp8f6hUmhOrjkNJ64c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EtiDd5pLHtCM47bBzFOvLkZBsQU9jhM8GJcogCJFkn/7oE+vNTaF7kFkCQPi4EpWEzlb3w8Dt8VufhhDEkYSbjq17QILF/gRWgrsSqvsYbjZorcgqpk3Ry8iPccYnP1Nnab0f4RMGNywqusZ9UoCUx+HWtHqXjorLG+P1/DCRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=bLwlzwgN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="bLwlzwgN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790608317; x=1791213117; i=t.fuechsel@gmx.de;
	bh=YEgIAeCUmp7CBcyDru8hnhjZcQIr2LIx1wqqPjLvE/8=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bLwlzwgN92i+Jab2IZGDPhVxSl/Y2+c5o5rHpwDmCK2VplU78DwgwbtnkjIfCDsf
	 dACZnsqA3ePt75xkBeFjvxk7klH1rfI8nv/OtUvUnQbpJ4tgLD8BCB2J30Y/AAs2H
	 e+3vvidm5X6uDK23jgeIOAkmLMHEHk8WRForsvDg+wfcxFadLo2o3S9VZfyeHQQ10
	 gUStMY87zUFYK4YzDhnvqMVIBoaxgWZ6a0TGltjHMEiUOoXWgo8P4e2N+D0vQ+rB4
	 /fTzvfjP7AMFVgdmIAZCTTL1ClwlmS1UPnECFsTzLX33OZ50OZr8Ua70RmfNtJEl8
	 pAeonw5QC8E0FtR36A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAgq-1wZgLF29IO-00iNWk; Mon, 28
 Sep 2026 17:11:57 +0200
Date: Mon, 28 Sep 2026 17:11:54 +0200
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
Subject: [PATCHv9 net-next] tcp: Add TCP ROCCET congestion control module.
Message-ID: <arqDuiD4Q4GWOFBc@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2e8tyXD3dTpLrxr/H7F+5vCJTNhDHywc6VEtxnK6gaBAgRp0b9k
 FV3Rc00gOJ44+L0zxSS/iSbNAYZ8cvAM9AoeeJ5C6wL9eWVaeszLoCqh9xS7AJptc3FQyes
 E7LBm0oQBgDlv2QmfHqu+V5rR/a6x810aXGztEuffEExhSLsrLgQ2YwtIfXim7A9Wsa0y7V
 MSgSyqCU2RNpZ7RfWFrCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8NMFGJxuQco=;CcPhCJNZIPgi2zkhxv467yO5ssW
 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

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
=2D--
 net/ipv4/Kconfig      |   12 +
 net/ipv4/Makefile     |    1 +
 net/ipv4/tcp_roccet.c | 1400 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1413 insertions(+)
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
index 000000000000..cd8c44490117
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,1400 @@
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
+ * A peer-reviewed paper on TCP ROCCET will be presented
+ * at the WONS 2026 conference.
+ * A draft of the paper is available here:
+ *		https://arxiv.org/abs/2510.25281
+ *
+ *
+ * Further information about CUBIC:
+ * TCP CUBIC: Binary Increase Congestion control for TCP v2.3
+ * Home page:
+ *	http://netsrv.csc.ncsu.edu/twiki/bin/view/Main/BIC
+ * This is from the implementation of CUBIC TCP in
+ * Sangtae Ha, Injong Rhee and Lisong Xu,
+ *  "CUBIC: A New TCP-Friendly High-Speed TCP Variant"
+ *  in ACM SIGOPS Operating System Review, July 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/cubic_a_new_tcp_2008.pdf
+ *
+ * CUBIC integrates a new slow start algorithm, called HyStart.
+ * The details of HyStart are presented in
+ *  Sangtae Ha and Injong Rhee,
+ *  "Taming the Elephants: New TCP Slow Start", NCSU TechReport 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/hystart_techreport_2008.pdf
+ *
+ * All testing results are available from:
+ * http://netsrv.csc.ncsu.edu/wiki/index.php/TCP_Testing
+ *
+ * Unless CUBIC is enabled and congestion window is large
+ * this behaves the same as the original Reno.
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
+MODULE_PARM_DESC(beta, "beta for multiplicative increase");
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
+	memset(ca, 0, sizeof(struct roccettcp));
+	ca->next_srrtt_check_ts =3D 0;
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
+	ca->last_event_time_set =3D false;
+	ca->ack_rate_last_rate =3D 0;
+
+	/* Initialize to current time to avoid an
+	 * overflow in the ack rate calculation
+	 */
+	ca->last_ack_rate_time =3D jiffies_to_usecs(tcp_jiffies32);
+	ca->curr_ack_rate =3D 0;
+	ca->ack_rate_cnt =3D 0;
+
+	ca->interval_snd_seq_start =3D tcp_sk(sk)->snd_nxt;
+	ca->interval_una_seq_start =3D tcp_sk(sk)->snd_una;
+
+	/* Start state is LAUNCH */
+	ca->state =3D LAUNCH;
+	ca->probe_min_rtt_until =3D 0;
+	ca->refill_until =3D 0;
+	ca->rtt_probe_timers_set =3D false;
+
+	ca->is_in_initial_launch =3D false;
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
+	ca->curr_srrtt =3D ((100 - ROCCET_ALPHA_TIMES_100) * (u64)ca->curr_srrtt=
 +
+			  ROCCET_ALPHA_TIMES_100 * rrtt) /
+			 100;
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
+	tcp_snd_cwnd_set(tp, probe_cwnd);
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
+	 * probe_min_rtt_until wrap-arounds are handled by the time_before32
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
+		tcp_snd_cwnd_set(tp, ca->cwnd_before_min_rtt_probe);
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
+static void roccet_cwnd_event_tx_start(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 now =3D tcp_jiffies32;
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
+		ca->epoch_start =3D 0;
+
+		/* Handle initial LAUNCH. Most bufferbloat occurs here */
+		if (ca->is_in_initial_launch) {
+			/* Halving the cwnd will undo the previous step of slow
+			 * start. Which is fine since the pipe is already full.
+			 */
+			tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) / 2,
+						 TCP_INIT_CWND));
+		} else {
+			tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) -
+						 (tcp_snd_cwnd(tp) / 3),
+						 TCP_INIT_CWND));
+		}
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
+	 */
+	sent_more_than_acked =3D (s32)(sent - received) >
+			       div_u64((u64)tcp_snd_cwnd(tp) *
+			       (u64)tp->mss_cache, 100);
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
+	 *
+	 * Also avoid cwnd-growth if we are in cwnd reduction phase.
+	 */
+	if (!tcp_is_cwnd_limited(sk) || sent_more_than_acked ||
+	    tcp_in_cwnd_reduction(sk))
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
+ * (e.g. in roccet_state() or roccet_control()).
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
+	 * initial_launch. Even on LAUNCH to LAUNCH transitions (on RTO).
+	 * Also on any state transition from LAUNCH, we can say that the
+	 * tcp_is_cwnd_limited() is now valid.
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
+		tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
+		WRITE_ONCE(tp->snd_ssthresh, max(tp->snd_ssthresh,
+						 TCP_INIT_CWND));
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
+		tcp_snd_cwnd_set(tp, cwnd);
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
+	u32 delay;
+
+	/* Some calls are for duplicates without timestamps */
+	if (sample->rtt_us < 0)
+		return;
+
+	/* Discard delay samples right after fast recovery */
+	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
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
+
+	/* Get valid sample for roccet */
+	if (sample->rtt_us > 0) {
+		ca->last_rtt =3D ca->curr_rtt;
+		ca->curr_rtt =3D sample->rtt_us;
+	}
+}
+
+/* Custom Pacing Rate for ROCCET TCP.
+ * The code here is similar to the pacing rate adjustments in tcp_input.c
+ * tcp_cong_control(). In (modified) slow start we want a pacing of 200% =
and
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
+	rate =3D (u64)tp->mss_cache * ((USEC_PER_SEC / 100) << 3);
+
+	/* current rate is (cwnd * mss) / srtt
+	 * In slow-start [1], set sk_pacing_rate to 200% the current rate.
+	 * Otherwise, set it to 100% the current rate.
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

base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
=2D-=20
2.43.0

